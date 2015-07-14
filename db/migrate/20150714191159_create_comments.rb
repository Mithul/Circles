class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.references :user, index: true
      t.references :post, polymorphic: true

      t.timestamps null: false
    end
    add_foreign_key :comments, :users
  end
end
