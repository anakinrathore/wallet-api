class CreateWallets < ActiveRecord::Migration[5.2]
  def change
    create_table :wallets, id: :uuid do |t|
      t.integer :balance_in_paise, :null => false, :default => 0

      t.timestamps
    end
  end
end
