class AddColumnsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :username, :string
    add_column :users, :media, :integer
    add_column :users, :follows, :integer
    add_column :users, :followed_by, :integer
  end
end
