require 'rails_helper'

RSpec.describe "AccountBlock::Accounts", type: :request do
  describe "GET /account_block/accounts" do
    it "works! (now write some real specs)" do
      get account_block_accounts_path
      expect(response).to have_http_status(200)
    end
  end
end
