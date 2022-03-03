require "json-schema"

class AccountsController < ApplicationController
  before_action :validate, only: :create

  CREATE_ACCOUNT_SCHEMA = {
    "type" => "object",
    "required" => %w[name document amount],
    "properties" => {
      "name" => { "type" => "string", "minLength" => 4, "maxLength" => 40 },
      "document" => { "type" => "string", "minLength" => 11, "maxLength" => 11 },
      "amount" => { "type" => "integer", "minimum" => 1 }
    }
  }.freeze

  def create
    account = AccountCase::CreateAccountCase.new(request.params[:name], request.params[:document], request.params[:amount]).create
    success(account, :created)
  rescue Error::CreateAccountError => error
    error(error.json, :unprocessable_entity)
  rescue Error::ServerError => error
    error(error.json, :internal_server_error)
  end

  private

  def validate
    error(Error::ValidationError.new.json, :bad_request) unless JSON::Validator.validate CREATE_ACCOUNT_SCHEMA, request.params
  end
end
