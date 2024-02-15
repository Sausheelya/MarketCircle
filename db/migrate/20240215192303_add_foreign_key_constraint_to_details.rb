class AddForeignKeyConstraintToDetails < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :details, :people, on_delete: :cascade
  end
end
