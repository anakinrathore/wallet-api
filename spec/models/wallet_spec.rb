require 'rails_helper'

RSpec.describe Wallet, type: :model do

  it { should validate_presence_of(:balance_in_paise) }

  describe 'create' do
    it 'should create a new wallet for the user' do
      user = create(:user)
      wallet = create(:wallet, balance_in_paise: 95000)
      user.wallet = wallet
      expect(Wallet.count).to eq 1
      expect(user.wallet.balance_in_paise).to eq 95000
    end
  end

  describe 'deposit' do
    it 'should deposit the wallet with a positive amount' do
      user = create(:user)
      wallet = create(:wallet, balance_in_paise: 95000)
      user.wallet = wallet
      wallet.deposit(5000)
      expect(user.wallet.balance_in_paise).to eq 100000
    end

    it 'should not deposit the wallet with a negative amount' do
      user = create(:user)
      wallet = create(:wallet, balance_in_paise: 95000)
      user.wallet = wallet
      wallet.deposit(-400)
      expect(user.wallet.balance_in_paise).to eq 95000
    end
  end

  describe 'withdraw' do
    it 'should withdraw the wallet with a positive amount' do
      user = create(:user)
      wallet = create(:wallet, balance_in_paise: 95000)
      user.wallet = wallet
      wallet.withdraw(5000)
      expect(user.wallet.balance_in_paise).to eq 90000
    end

    it 'should not withdraw the wallet with a negative amount' do
      user = create(:user)
      wallet = create(:wallet, balance_in_paise: 95000)
      user.wallet = wallet
      wallet.withdraw(-400)
      expect(user.wallet.balance_in_paise).to eq 95000
    end

    it 'should not withdraw the wallet when balance is 0 paise' do
      user = create(:user)
      wallet = create(:wallet, balance_in_paise: 0)
      user.wallet = wallet
      wallet.withdraw(500)
      expect(user.wallet.balance_in_paise).to eq 0
    end
  end

end
