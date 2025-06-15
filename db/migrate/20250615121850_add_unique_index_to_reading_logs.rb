class AddUniqueIndexToReadingLogs < ActiveRecord::Migration[7.1]
  def change
    add_index :reading_logs, [:user_id, :book_id], unique: true
  end
end
