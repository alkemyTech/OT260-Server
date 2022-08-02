class NotNullValueToBodyFromComments < ActiveRecord::Migration[6.1]
  def change
    change_column_null :comments, :body, false
  end
end
