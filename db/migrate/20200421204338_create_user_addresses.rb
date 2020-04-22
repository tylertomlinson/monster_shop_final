class CreateUserAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :user_addresses do |t|
      t.integer :nickname, default: 0
      t.string :address
      t.string :city
      t.string :state
      t.integer :zip
      t.references :user, foreign_key: true
    end
  end
end
