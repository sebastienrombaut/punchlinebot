class ChangeIntegerLimitInUser < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :facebook_id, :integer, limit: 8
  end
end
