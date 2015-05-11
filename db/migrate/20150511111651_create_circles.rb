class CreateCircles < ActiveRecord::Migration
  def change
    create_table :circles do |t|
      t.string :name
      t.references :circle, index: true

      t.timestamps null: false
    end
    add_foreign_key :circles, :circles
  end
end
