class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.string :description

      t.timestamps

      t.datetime :discarded_at
      t.index :discarded_at
    end
  end
end
