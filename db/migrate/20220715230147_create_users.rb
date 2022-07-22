class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :first_name, null: false 
      t.string :last_name, null: false
      t.string :email, null: false, index: { unique: true }
      t.string :password_digest, null: false
      t.string :photo
      t.references :role, null: false, foreign_key: true

      t.timestamps

      t.datetime :discarded_at
      t.index :discarded_at
      
    end
  end
end
