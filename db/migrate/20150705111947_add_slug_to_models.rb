class AddSlugToModels < ActiveRecord::Migration
  def change
    add_column :circles, :slug, :string, unique: true
    add_column :users, :slug, :string, unique: true
    add_column :members, :slug, :string, unique: true
    add_column :reports, :slug, :string, unique: true
  end
end
