class AddOmniauthToMembers < ActiveRecord::Migration[5.0]
  def up
    add_column :members, :provider, :string
    add_column :members, :uid, :string
  end

  def down
    remove_column :members, :provider, :string
    remove_column :members, :uid, :string
  end
end
