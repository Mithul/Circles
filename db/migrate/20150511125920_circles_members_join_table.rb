class CirclesMembersJoinTable < ActiveRecord::Migration
  def change
  	create_table :circles_members do |t|
      t.references :member, index: true
      t.references :circle, index: true
      t.string :designation

      t.timestamps null: false
    end
  end
end
