class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.references :author, null: false, foreign_key: true
      t.string :id
      t.string :title
      t.date :published_date
      t.string :thumbnail_link
      t.text :description
      t.string :isbn

      t.timestamps
    end
  end
end
