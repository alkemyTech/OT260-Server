class RemoveImageUrlFieldToSlides < ActiveRecord::Migration[6.1]
  def change
    remove_column :slides, :image_url
  end
end
