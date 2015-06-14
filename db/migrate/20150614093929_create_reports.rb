class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|

      t.string :title
      t.date :date
      t.string :duration
      t.string :venue
      t.string :initiator
      t.string :bucket
      t.string :participants
      t.text :description
      t.text :conclusion
      t.string :author
      t.boolean :inter
      t.string :othbucket
      t.time :time
      t.time :category

      t.timestamps null: false
    end
  end
end
