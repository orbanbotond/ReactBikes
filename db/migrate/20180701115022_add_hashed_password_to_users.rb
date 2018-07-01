class AddHashedPasswordToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :hashed_password, :string
    add_column :users, :hashed_session_token, :string
    remove_column :users, :password, :string
  end
end
