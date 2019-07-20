class User < ApplicationRecord
  has_many :wallets, as: :walletable
  has_and_belongs_to_many :groups
  validates_presence_of :first_name, :phone_number
end
