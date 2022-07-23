class CreateSlides < ActiveRecord::Migration[6.1]
  def change
    create_table :slides do |t|
      t.text :text, null: false
      t.integer :order, null: false
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
