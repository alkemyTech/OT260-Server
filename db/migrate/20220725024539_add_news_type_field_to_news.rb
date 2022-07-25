class AddNewsTypeFieldToNews < ActiveRecord::Migration[6.1]
  def change
    add_column :news, :news_type, :string, default: 'news'
  end
end
