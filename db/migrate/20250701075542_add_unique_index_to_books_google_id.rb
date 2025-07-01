class AddUniqueIndexToBooksGoogleId < ActiveRecord::Migration[7.1]
  def change
    add_index :books, :google_id, unique: true
  end
end
