class CreateWellspringUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :wellspring_users do |t|
      t.string :email
      t.string :name
      t.string :password_digest
      t.string :auth_token

      t.timestamps
    end
  end
end
