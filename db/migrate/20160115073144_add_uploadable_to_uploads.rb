class AddUploadableToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :uploadable_id, :integer
    add_column :uploads, :uploadable_type, :string
  end
end
