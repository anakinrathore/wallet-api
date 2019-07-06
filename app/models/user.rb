class User < ApplicationRecord
  has_one :wallet

  validates_presence_of :first_name, :phone_number
end
