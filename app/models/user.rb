class User < ApplicationRecord
  has_many :wallets, as: :walletable

  validates_presence_of :first_name, :phone_number
end
