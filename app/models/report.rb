class Report < ActiveRecord::Base
	has_paper_trail
	belongs_to :user
	extend FriendlyId
  	friendly_id :title,  use: [:slugged, :finders]
end
