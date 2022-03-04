require "json-schema"

class TransfersController < ApplicationController
  before_action :validate, only: :create

  CREATE_TRANSFER_SCHEMA = {
    "type" => "object",
    "required" => %w[sender_document receiver_document amount],
    "properties" => {
      "sender_document" => { "type" => "string", "minLength" => 11, "maxLength" => 11 },
      "receiver_document" => { "type" => "string", "minLength" => 11, "maxLength" => 11 },
      "amount" => { "type" => "integer", "minimum" => 1 }
    }
  }.freeze

  def index
    transfers = TransferCase::GetTransferAccountCase.new(request.params[:account_id]).list
    success(transfers, :ok)
  end

  def create
    amount = request.params[:amount]
    sender_document = request.params[:sender_document]
    receiver_document = request.params[:receiver_document]

    transfer = TransferCase::CreateTransferCase.new(amount, sender_document, receiver_document).create
    success(transfer, :created)
  rescue Error::AccountNotFoundError => error
    error(error.json, :unprocessable_entity)
  rescue Error::InsufficientBalanceError => error
    error(error.json, :unprocessable_entity)
  rescue Error::DuplicateTransactionError => error
    error(error.json, :unprocessable_entity)
  rescue Error::ServerError => error
    error(error.json, :internal_server_error)
  end

  private

  def validate
    error(Error::ValidationError.new.json, :bad_request) unless JSON::Validator.validate CREATE_TRANSFER_SCHEMA, request.params
  end
end
