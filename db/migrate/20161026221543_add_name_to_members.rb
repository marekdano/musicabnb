class AddNameToMembers < ActiveRecord::Migration[5.0]
  def up
    add_column :members, :name, :string
  end

  def down
    remove_column :members, :name, :string
  end
end
