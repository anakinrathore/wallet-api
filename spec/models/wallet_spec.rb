require 'rails_helper'

RSpec.describe Wallet, type: :model do

  it { should validate_presence_of(:balance_in_paise) }

  describe 'create' do
    it 'should create a new wallet' do
      wallet = create(:wallet, balance_in_paise: 95000)
      expect(Wallet.count).to eq 1
      expect(Wallet.first.balance_in_paise).to eq 95000
    end
  end
end
