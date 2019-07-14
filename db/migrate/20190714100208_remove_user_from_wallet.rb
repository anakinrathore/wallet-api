class RemoveUserFromWallet < ActiveRecord::Migration[5.2]
  def change
    remove_column :wallets, :user_id, :uuid
  end
end
