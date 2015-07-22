class CreateChecklistItems < ActiveRecord::Migration
  def change
    create_table :checklist_items do |t|
      t.string :title
      t.boolean :checked
      t.datetime :deadline
      t.belongs_to :checklist, index: true
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :checklist_items, :checklists
  end
end
