class Report < ActiveRecord::Base
	has_paper_trail
	belongs_to :user
	extend FriendlyId
  	friendly_id :title,  use: [:slugged, :finders]

  	def circle
  		Circle.where(name: self.bucket).first
  	end

  	def task_title
  		return self.title + ' ('+self.category.capitalize+')' if self.category
  		return self.title if !self.category
  	end

  	def task_category
  		'Report'
  	end

  	def task_date
		d = self.date
		t = self.time
		dt = DateTime.new(d.year, d.month, d.day, t.hour, t.min, t.sec, t.zone)
  	end
end
