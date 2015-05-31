class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.references :circle, index: true
      t.references :member, index: true
      t.string :name
      t.text :description

      t.timestamps null: false
    end
    add_foreign_key :roles, :circles
    add_foreign_key :roles, :members
  end
end
