class RenameIsReadToReadingStatusInReadingLogs < ActiveRecord::Migration[7.1]
  def change
    rename_column :reading_logs, :is_read, :reading_status
  end
end
