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

  describe 'POST#create_shared' do
    it 'should create a new wallet for the group of users' do
      group = Group.create(kind: "friend")
      user = create_list(:user, 5, group_id: group.id)
      expect {
        post :create_shared, params: {  "group_id": group.id, "balance_in_paise": 50000 }
      }.to change(Wallet, :count).by(1)
    end

    it 'should not create a new wallet if the group doesn\'t exist' do
      expect {
        post :create_shared, params: {  "group_id": "1a4d0db0-7a86-4345-8980-0e7045032111", "balance_in_paise": 60000 }
      }.to change(Wallet, :count).by(0)
      expect(response).to have_http_status 400
      expect(json["errors"]).to eq "Group with id: 1a4d0db0-7a86-4345-8980-0e7045032111 not found"
    end
  end

  describe 'POST#deposit' do
    it 'should increase the wallet balance when amount is positive' do
      user = create(:user)
      wallet = user.wallets.create(balance_in_paise:500)
      put :deposit, params: {  "user_id": user.id, "wallet_id": wallet.id, "deposit_amount": 40000 }
      wallet.reload
      expect(wallet.balance_in_paise).to eq 40500
      expect(response).to have_http_status 200
    end

    it 'should not increase the wallet balance when amount is negative' do
      user = create(:user)
      wallet = user.wallets.create(balance_in_paise:500)
      put :deposit, params: {  "user_id": user.id, "wallet_id": wallet.id, "deposit_amount": -600 }
      wallet.reload
      expect(wallet.balance_in_paise).to eq 500
      expect(response).to have_http_status 200
    end
  end

  describe 'POST#withdraw' do
    it 'should decrease the wallet balance when amount is positive' do
      user = create(:user)
      wallet = user.wallets.create(balance_in_paise:60000)
      put :withdraw, params: {  "user_id": user.id, "wallet_id": wallet.id, "withdrawl_amount": 40000 }
      wallet.reload
      expect(wallet.balance_in_paise).to eq 20000
      expect(response).to have_http_status 200
    end

    it 'should not decrease the wallet balance when amount is negative' do
      user = create(:user)
      wallet = user.wallets.create(balance_in_paise:500)
      put :withdraw, params: {  "user_id": user.id, "wallet_id": wallet.id, "withdrawl_amount": -600 }
      wallet.reload
      expect(wallet.balance_in_paise).to eq 500
      expect(response).to have_http_status 200
    end

    it 'should not decrease the wallet balance when amount is 0' do
      user = create(:user)
      wallet = user.wallets.create(balance_in_paise:0)
      put :withdraw, params: {  "user_id": user.id, "wallet_id": wallet.id, "withdrawl_amount": 500 }
      wallet.reload
      expect(wallet.balance_in_paise).to eq 0
      expect(response).to have_http_status 200
    end
  end
end