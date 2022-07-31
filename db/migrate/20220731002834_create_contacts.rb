class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.string :name, null: false
      t.string :phone
      t.string :email, null: false
      t.text :message

      t.timestamps

      t.datetime :discarded_at
      t.index :discarded_at
    end
  end
end
