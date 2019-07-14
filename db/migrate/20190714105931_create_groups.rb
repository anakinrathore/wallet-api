class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups, id: :uuid do |t|
      t.string :kind

      t.timestamps
    end
  end
end
