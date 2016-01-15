class Upload < ActiveRecord::Base
  belongs_to :user
  has_attached_file :file
  validates_attachment :file, content_type: { content_type: ["application/pdf","image/jpeg", "image/gif", "image/png"] }
  has_and_belongs_to_many :reports

  def _exist
  end
end
