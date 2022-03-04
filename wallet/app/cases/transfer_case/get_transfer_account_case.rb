module TransferCase
  class GetTransferAccountCase
    def initialize(account_id)
      @account_id = account_id
    end

    def list
      transfers = Transfer.where(account_id: @account_id)
      build_transfer transfers
    end

    private

    def build_transfer(transfers)
      transfers.map do |transfer|
        {
          id: transfer.id,
          create: transfer.created_at,
          transaction_send: {
            id: transfer.transaction_send.id,
            kind: transfer.transaction_send.kind,
            amount: transfer.transaction_send.amount
          },
          transaction_receive: {
            id: transfer.transaction_receive.id,
            kind: transfer.transaction_receive.kind,
            amount: transfer.transaction_receive.amount
          },
          account: {
            id: transfer.account.id,
            name: transfer.account.name,
            document: transfer.account.document
          }
        }
      end
    end
  end
end
