class Wallet < ApplicationRecord

  validates_presence_of :balance_in_paise
end
