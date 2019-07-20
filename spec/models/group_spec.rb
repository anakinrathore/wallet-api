require 'rails_helper'

RSpec.describe Group, type: :model do

  it { should validate_presence_of(:kind) }

  it { should have_many(:wallets) }

  it { should have_and_belong_to_many(:users) }

  describe 'create' do
    it 'should create a new group' do
      group = Group.create(kind: "Family")
      group.users << create_list(:user, 10)
      expect(Group.count).to eq 1
      expect(Group.first.users.count).to eq 10
    end
  end
end
