class AddUserToAccesstokens < ActiveRecord::Migration[5.0]
  def change
  	add_column :accesstokens, :user_id, :integer
  end
end
