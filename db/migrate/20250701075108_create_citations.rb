class CreateCitations < ActiveRecord::Migration[7.1]
  def change
    create_table :citations do |t|
      t.references :reading_log, null: false, foreign_key: true
      t.text :content
      t.string :page_number

      t.timestamps
    end
  end
end
