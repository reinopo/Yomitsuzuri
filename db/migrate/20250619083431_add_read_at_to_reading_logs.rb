class AddReadAtToReadingLogs < ActiveRecord::Migration[7.1]
  def change
    add_column :reading_logs, :read_at, :datetime
  end
end
