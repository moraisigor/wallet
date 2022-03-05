require "rails_helper"

RSpec.describe TransfersController, type: :request do

  describe "Get Transfer Account" do
    let(:id) { SecureRandom.uuid }
    let(:header) { build(:header) }
    let(:get_transfer_account_success_response) { build_list(:get_transfer_account_success_response, 20) }

    let(:get_transfer_account_case) { spy("TransferCase::GetTransferAccountCase") }

    before do
      allow(TransferCase::GetTransferAccountCase).to receive(:new).and_return(get_transfer_account_case)
    end

    subject do
      get "/api/accounts/#{id}/transfers", headers: header
      response
    end

    context "when get transfer account history" do
      before do
        allow(get_transfer_account_case).to receive(:list).and_return(get_transfer_account_success_response)
      end

      it { is_expected.to have_http_status(:ok) }
      it { expect(subject.body).to eq(get_transfer_account_success_response.to_json) }
    end
  end

  describe "Create Transfer" do
    let(:header) { build(:header) }
    let(:create_transfer_request) { build(:create_transfer_request) }

    let(:create_transfer_account_not_found_error_response) { build(:create_transfer_error_response, :account_not_found_error) }
    let(:create_transfer_insufficient_balance_error_response) { build(:create_transfer_error_response, :insufficient_balance_error) }
    let(:create_transfer_duplicate_transaction_error_response) { build(:create_transfer_error_response, :duplicate_transaction_error) }
    let(:create_transfer_server_error_response) { build(:create_transfer_error_response, :server_error) }

    let(:create_transfer_success_response) { build(:create_transfer_success_response) }

    let(:create_transfer_case) { spy("TransferCase::CreateTransferCase") }

    before do
      allow(TransferCase::CreateTransferCase).to receive(:new).and_return(create_transfer_case)
    end

    subject do
      post "/api/transfers", headers: header, params: create_transfer_request, as: :json
      response
    end

    context "when create transfer with success" do
      before do
        allow(create_transfer_case).to receive(:create).and_return(create_transfer_success_response)
      end

      it { is_expected.to have_http_status(:created) }
      it { expect(subject.body).to eq(create_transfer_success_response.to_json) }
    end

    context "when create transfer to a nonexistent account" do
      before do
        allow(create_transfer_case).to receive(:create).and_raise(Error::AccountNotFoundError)
      end

      it { is_expected.to have_http_status(:unprocessable_entity) }
      it { expect(subject.body).to eq(create_transfer_account_not_found_error_response.to_json) }
    end

    context "when create transfer with an insufficient balance" do
      before do
        allow(create_transfer_case).to receive(:create).and_raise(Error::InsufficientBalanceError)
      end

      it { is_expected.to have_http_status(:unprocessable_entity) }
      it { expect(subject.body).to eq(create_transfer_insufficient_balance_error_response.to_json) }
    end

    context "when create transfer that is duplicated" do
      before do
        allow(create_transfer_case).to receive(:create).and_raise(Error::DuplicateTransactionError)
      end

      it { is_expected.to have_http_status(:unprocessable_entity) }
      it {
        expect(subject.body).to eq(create_transfer_duplicate_transaction_error_response.to_json) }
    end

    context "when create transfer and get a generic error" do
      before do
        allow(create_transfer_case).to receive(:create).and_raise(Error::ServerError)
      end

      it { is_expected.to have_http_status(:internal_server_error) }
      it { expect(subject.body).to eq(create_transfer_server_error_response.to_json) }
    end
  end
end
