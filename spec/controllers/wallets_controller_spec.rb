require 'rails_helper'

RSpec.describe WalletsController, type: :controller do

  describe 'POST#create' do
    it 'should create a new wallet for the user' do
      user = create(:user)
      expect {
        post :create, params: {  "user_id": user.id, "balance_in_paise": 50000 }
      }.to change(Wallet, :count).by(1)

    end

    it 'should not create a new wallet if the user doesn\'t exist' do
      expect {
        post :create, params: {  "user_id": "1a4d0db0-7a86-4345-8980-0e7045032111", "balance_in_paise": 60000 }
      }.to change(Wallet, :count).by(0)
      expect(response).to have_http_status 400
      expect(json["errors"]).to eq "User with id: 1a4d0db0-7a86-4345-8980-0e7045032111 not found"
    end
  end
end