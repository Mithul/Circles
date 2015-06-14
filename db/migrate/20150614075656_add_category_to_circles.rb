class AddCategoryToCircles < ActiveRecord::Migration
  def change
    add_column :circles, :category, :string
  end
end
