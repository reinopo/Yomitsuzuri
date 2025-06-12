class CreateReadingLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :reading_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.integer :reading_status
      t.text :comment
      t.text :citation

      t.timestamps
    end
  end
end
