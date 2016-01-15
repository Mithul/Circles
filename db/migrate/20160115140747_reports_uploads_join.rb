class ReportsUploadsJoin < ActiveRecord::Migration
  def change
    create_table :reports_uploads do |t|
      t.references :report, index: true
      t.references :upload, index: true
    end
  end
end
