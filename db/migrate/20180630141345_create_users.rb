# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.boolean :admin
      t.string :password

      t.timestamps
    end
  end
end
