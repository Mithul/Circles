class CreateChecklists < ActiveRecord::Migration
  def change
    create_table :checklists do |t|
      t.string :title
      t.references :circle, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :checklists, :circles
    add_foreign_key :checklists, :users
  end
end
