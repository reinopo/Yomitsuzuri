class AddPageNumberToCitations < ActiveRecord::Migration[7.1]
  def change
    add_column :citations, :page_number, :string
  end
end
