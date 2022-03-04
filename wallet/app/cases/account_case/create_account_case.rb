module AccountCase
  class CreateAccountCase
    def initialize(name, document, amount)
      @name = name
      @document = document
      @amount = amount
    end

    def create
      raise Error::CreateAccountError if Account.find_by_document @document

      account = Account.new(name: @name, document: @document)
      transaction = Transaction.new(kind: :credit, amount: @amount, account: account)

      begin
        Account.transaction do
          raise StandardError unless account.save
          raise StandardError unless transaction.save
        end

        return { id: account.id, name: account.name, document: account.document, amount: transaction.amount }
      rescue
        raise Error::ServerError
      end
    end
  end
end
