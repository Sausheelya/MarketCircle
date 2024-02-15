class CreateDetails < ActiveRecord::Migration[7.1]
  def change
    create_table :details do |t|
      t.string :email
      t.string :title
      t.integer :age
      t.string :phone
      t.references :person, null: false, foreign_key: true

      t.timestamps
    end
  end
end
