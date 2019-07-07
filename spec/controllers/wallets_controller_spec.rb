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

  describe 'POST#deposit' do
    it 'should increase the wallet balance when amount is positive' do
      user = create(:user)
      user.wallet = create(:wallet, balance_in_paise:500)
      post :deposit, params: {  "user_id": user.id, "deposit_amount": 40000 }
      user.wallet.reload
      expect(user.wallet.balance_in_paise).to eq 40500
      expect(response).to have_http_status 200
    end

    it 'should not increase the wallet balance when amount is negative' do
      user = create(:user)
      user.wallet = create(:wallet, balance_in_paise:500)
      post :deposit, params: {  "user_id": user.id, "deposit_amount": -600 }
      user.wallet.reload
      expect(user.wallet.balance_in_paise).to eq 500
      expect(response).to have_http_status 200
    end
  end

  describe 'POST#withdraw' do
    it 'should decrease the wallet balance when amount is positive' do
      user = create(:user)
      user.wallet = create(:wallet, balance_in_paise:60000)
      post :withdraw, params: {  "user_id": user.id, "withdrawl_amount": 40000 }
      user.wallet.reload
      expect(user.wallet.balance_in_paise).to eq 20000
      expect(response).to have_http_status 200
    end

    it 'should not decrease the wallet balance when amount is negative' do
      user = create(:user)
      user.wallet = create(:wallet, balance_in_paise:500)
      post :withdraw, params: {  "user_id": user.id, "withdrawl_amount": -600 }
      user.wallet.reload
      expect(user.wallet.balance_in_paise).to eq 500
      expect(response).to have_http_status 200
    end

    it 'should not decrease the wallet balance when amount is 0' do
      user = create(:user)
      user.wallet = create(:wallet, balance_in_paise:0)
      post :withdraw, params: {  "user_id": user.id, "withdrawl_amount": 500 }
      user.wallet.reload
      expect(user.wallet.balance_in_paise).to eq 0
      expect(response).to have_http_status 200
    end
  end
end