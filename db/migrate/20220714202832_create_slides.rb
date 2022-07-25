class CreateSlides < ActiveRecord::Migration[6.1]
  def change
    create_table :slides do |t|
      t.string :image_url
      t.string :text
      t.integer :order
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
