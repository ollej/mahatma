class AddForwardingToUser < ActiveRecord::Migration
  def change
    add_column :users, :forward_address, :string
    add_column :users, :forward_destination, :string
  end
end
