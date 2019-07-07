class Wallet < ApplicationRecord

  validates_presence_of :balance_in_paise

  def deposit(deposit_amount)
    self.balance_in_paise = self.balance_in_paise + deposit_amount.to_i if not deposit_amount.to_i.negative?
    self.save
  end

  def withdraw(withdrawl_amount)
    if self.balance_in_paise > 0
      self.balance_in_paise = self.balance_in_paise - withdrawl_amount.to_i if not withdrawl_amount.to_i.negative?
      self.save
    end
  end
end
