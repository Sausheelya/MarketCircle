class CreatePeople < ActiveRecord::Migration[7.1]
  def change
    create_table :people do |t|
      t.string :name
      t.string :email
      t.string :title
      t.integer :age
      t.string :phone

      t.timestamps
    end
  end
end
