class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :category
      t.text :description
      t.references :circle, index: true

      t.timestamps null: false
    end
    add_foreign_key :tasks, :circles
  end
end
