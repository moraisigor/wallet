require "rails_helper"

RSpec.describe AccountsController, type: :request do

  describe "Create Account" do
    let(:header) { build(:header) }
    let(:create_account_request) { build(:create_account_request) }
    let(:create_account_error_response) { build(:create_account_error_response) }
    let(:create_account_success_response) { build(:create_account_success_response) }

    let(:create_account_case) { spy("AccountCase::CreateAccountCase") }

    before do
      allow(AccountCase::CreateAccountCase).to receive(:new).and_return(create_account_case)
    end

    subject do
      post "/api/accounts", headers: header, params: create_account_request, as: :json
      response
    end

    context "when create account with success" do
      before do
        allow(create_account_case).to receive(:create).and_return(create_account_success_response)
      end

      it { is_expected.to have_http_status(:created) }
      it { expect(subject.body).to eq(create_account_success_response.to_json) }
    end

    context "when create account with document already used" do
      before do
        allow(create_account_case).to receive(:create).and_raise(Error::CreateAccountError)
      end

      it { is_expected.to have_http_status(:unprocessable_entity) }
      it { expect(subject.body).to eq(create_account_error_response.to_json) }
    end
  end
end
