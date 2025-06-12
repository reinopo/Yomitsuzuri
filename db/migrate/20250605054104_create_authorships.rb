class CreateAuthorships < ActiveRecord::Migration[7.1]
  # 本と著者の多対多の関係（一人の著者は複数の本を書く＆一つの本を複数の著者で書くことがある）を保存するための中間テーブル
  def change
    create_table :authorships do |t|
      t.references :book, null: false, foreign_key: true
      t.references :author, null: false, foreign_key: true

      t.timestamps
    end
  end
end
