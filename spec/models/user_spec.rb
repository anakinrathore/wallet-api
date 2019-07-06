require 'rails_helper'

RSpec.describe User, type: :model do

  it { should validate_presence_of(:first_name) }

  it { should validate_presence_of(:phone_number) }

  it { should have_one(:wallet) }

  describe 'create' do
    it 'should create a new user' do
      user = create(:user)
      expect(User.count).to eq 1
      expect(User.first.id).to eq user.id
    end

    it 'should create multiple users' do
      users = create_list(:user ,10)
      expect(User.count).to eq 10
    end
  end
end
