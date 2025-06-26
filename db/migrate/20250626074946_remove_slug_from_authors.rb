class RemoveSlugFromAuthors < ActiveRecord::Migration[7.1]
  def change
    remove_column :authors, :slug, :string
  end
end
