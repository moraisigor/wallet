module TransferCase
  class CreateTransferCase
    def initialize(amount, sender_document, receiver_document)
      @amount = amount
      @sender_document = sender_document
      @receiver_document = receiver_document

      @sender_account = Account.find_by_document sender_document
      @receiver_account = Account.find_by_document receiver_document
    end

    def create
      raise Error::AccountNotFoundError unless @sender_account
      raise Error::AccountNotFoundError unless @receiver_account
      raise Error::InsufficientBalanceError unless @amount <= balance
      raise Error::DuplicateTransactionError if has_duplicate?

      transaction_send = Transaction.new(kind: :debit, amount: @amount, account: @sender_account)
      transaction_receive = Transaction.new(kind: :credit, amount: @amount, account: @receiver_account)
      transfer = Transfer.new(transaction_send: transaction_send, transaction_receive: transaction_receive, account: @sender_account)

      begin
        Transfer.transaction do
          raise StandardError unless transaction_send.save
          raise StandardError unless transaction_receive.save
          raise StandardError unless transfer.save
        end

        return { id: transfer.id, create: transfer.created_at, amount: balance, sender_document: @sender_account.document, receiver_document: @receiver_account.document }
      rescue
        raise Error::ServerError
      end
    end

    private

    def has_duplicate?
      transfers = Transfer.where(created_at: 2.minute.ago..Time.now, accounts: @sender_account)

      transfers.any? do |transfer|
        transfer.transaction_send.amount == @amount &&
          transfer.transaction_send.account.id == @sender_account.id &&
          transfer.transaction_receive.account.id == @receiver_account.id
      end
    end

    def balance
      Account.find(@sender_account.id).transactions.reduce(0) do |amount, transaction|
        amount -= transaction.amount if transaction.is_debit?
        amount += transaction.amount if transaction.is_credit?
        amount
      end
    end
  end
end
