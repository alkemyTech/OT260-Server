class RemoveImageFromNews < ActiveRecord::Migration[6.1]
  def change
    remove_column :news, :image, :string
  end
end
