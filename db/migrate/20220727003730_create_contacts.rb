class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.string :name
      t.integer :phone
      t.string :email
      t.date :deletedAt

      t.timestamps
    end
  end
end
