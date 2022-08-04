class RemovePhotoFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :photo, :string
  end
end
