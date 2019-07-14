require 'rails_helper'

RSpec.describe Wallet, type: :model do

  it { should validate_presence_of(:balance_in_paise) }

  describe 'create' do
    it 'should create a new wallet for the user' do
      user = create(:user)
      user.wallets.create(balance_in_paise: 95000)
      expect(Wallet.count).to eq 1
      expect(user.wallets.first.balance_in_paise).to eq 95000
    end
  end

  describe 'deposit' do
    it 'should deposit the wallet with a positive amount' do
      user = create(:user)
      wallet = user.wallets.create(balance_in_paise: 95000)
      wallet.deposit(5000)
      expect(wallet.balance_in_paise).to eq 100000
    end

    it 'should not deposit the wallet with a negative amount' do
      user = create(:user)
      wallet = user.wallets.create(balance_in_paise: 95000)
      wallet.deposit(-400)
      expect(wallet.balance_in_paise).to eq 95000
    end
  end

  describe 'withdraw' do
    it 'should withdraw the wallet with a positive amount' do
      user = create(:user)
      wallet = user.wallets.create(balance_in_paise: 95000)
      wallet.withdraw(5000)
      expect(wallet.balance_in_paise).to eq 90000
    end

    it 'should not withdraw the wallet with a negative amount' do
      user = create(:user)
      wallet = user.wallets.create(balance_in_paise: 95000)
      wallet.withdraw(-400)
      expect(wallet.balance_in_paise).to eq 95000
    end

    it 'should not withdraw the wallet when balance is 0 paise' do
      user = create(:user)
      wallet = user.wallets.create(balance_in_paise: 0)
      wallet.withdraw(500)
      expect(wallet.balance_in_paise).to eq 0
    end
  end

end
