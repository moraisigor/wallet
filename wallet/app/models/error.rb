module Error
  class BaseError < StandardError
    def initialize(code, message)
      @code = code
      @message = message
    end

    def json
      { code: @code, message: @message }
    end
  end

  class ValidationError < BaseError
    def initialize
      super(:validation_error, "error validation")
    end
  end

  class AccountNotFoundError < BaseError
    def initialize
      super(:account_not_found_error, "account not found")
    end
  end

  class CreateAccountError < BaseError
    def initialize
      super(:create_account_error, "the account has already been created")
    end
  end

  class InsufficientBalanceError < BaseError
    def initialize
      super(:insufficient_balance_error, "the account does not have enough balance")
    end
  end

  class DuplicateTransactionError < BaseError
    def initialize
      super(:duplicate_transaction_error, "the transaction is duplicated")
    end
  end

  class ServerError < BaseError
    def initialize
      super(:server_error, "the server had an unexpected error")
    end
  end
end
