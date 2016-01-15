class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.attachment :file
      t.references :user, index: true
      t.string :name

      t.timestamps null: false
    end
    add_foreign_key :uploads, :users
  end
end
