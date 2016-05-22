class Upload < ActiveRecord::Base
  belongs_to :user
  has_attached_file :file
  validates_attachment :file, content_type: { content_type: ["application/pdf","image/jpeg", "image/gif", "image/png",  'application/msword','applicationvnd.ms-word','applicaiton/vnd.openxmlformats-officedocument.wordprocessingm1.document','application/msexcel','application/vnd.ms-excel','application/vnd.openxmlformats-officedocument.spreadsheetml.sheet','application/mspowerpoint','application/vnd.ms-powerpoint','application/vnd.openxmlformats-officedocument.presentationml.presentation'] }
  has_and_belongs_to_many :reports

  def _exist
  end
end
