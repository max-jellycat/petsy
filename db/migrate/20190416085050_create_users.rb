class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.boolean :confirmed, default: false
      t.string :confirmation_token
      t.string :password_digest
      t.string :first_name
      t.string :last_name
      t.boolean :avatar, default: false

      t.timestamps
    end
  end
end