class CreateDetails < ActiveRecord::Migration[7.1]
  def change
    create_table :details do |t|
      t.text :description
      t.references :person, null: false, foreign_key: true

      t.timestamps
    end
  end
end
