class ChangeWalletableIdToBeUuidInWallets < ActiveRecord::Migration[5.2]
  def change
    remove_column :wallets, :walletable_id, :bigint
    add_column :wallets, :walletable_id, :uuid
  end
end
