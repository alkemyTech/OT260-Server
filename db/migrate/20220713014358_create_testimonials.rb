class CreateTestimonials < ActiveRecord::Migration[6.1]
  def change
    create_table :testimonials do |t|
    	t.string :name, null: false
      t.string :content
      t.datetime :discarded_at

      t.timestamps
    end  
    add_index :testimonials, :discarded_at
  end
end
