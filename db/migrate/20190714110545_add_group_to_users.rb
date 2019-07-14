class AddGroupToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :group, default: nil, type: :uuid, index: true
  end
end
