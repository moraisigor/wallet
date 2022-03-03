require "rails_helper"

RSpec.describe AccountsController, type: :controller do

  describe "create account" do
    let(:header) { build :header }
    let(:request) { build(:create_account_request) }
    let(:create_account) { spy('AccountCase::CreateAccountCase') }

    before do
      allow(AccountCase::CreateAccountCase).to receive(:new).and_return(create_account)
    end

    subject do
      post "/api/accounts", headers: header, params: request, as: :json
      response
    end

    context "when create account with success" do
      let(:response) { build(:create_account_response) }

      it { is_expected.to have_http_status(:ok) }
      it { expect(subject.body).to eq(response.to_json) }
    end

    context "when create account with document already used" do
      let(:response) { build(:create_account_response) }

      it { is_expected.to have_http_status(:unprocessable_entity) }
      it { expect(subject.body).to eq(response.to_json) }
    end
  end
end
