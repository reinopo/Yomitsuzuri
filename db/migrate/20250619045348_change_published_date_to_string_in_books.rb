class ChangePublishedDateToStringInBooks < ActiveRecord::Migration[7.1]
  def change
    change_column :books, :published_date, :string
  end
end
