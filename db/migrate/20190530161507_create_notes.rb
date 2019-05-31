class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.string :text
      t.string :title
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
