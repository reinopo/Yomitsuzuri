class RemoveSlugFromBooks < ActiveRecord::Migration[7.1]
  def change
    remove_column :books, :slug, :string
  end
end
