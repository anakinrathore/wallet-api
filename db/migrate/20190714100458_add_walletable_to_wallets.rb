class AddWalletableToWallets < ActiveRecord::Migration[5.2]
  def change
    add_reference :wallets, :walletable, polymorphic: true
  end
end
