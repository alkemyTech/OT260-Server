class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.string :name
      t.integer :phone
      t.string :email
      t.string :message
      t.string :deletedAt

      t.timestamps
    end
  end
end
