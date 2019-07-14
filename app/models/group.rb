class Group < ApplicationRecord
  has_many :wallets, as: :walletable
  has_many :users
  validates_presence_of :kind
end
