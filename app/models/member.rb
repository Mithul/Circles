class Member < ActiveRecord::Base
	has_and_belongs_to_many :circles
	accepts_nested_attributes_for :circles, :reject_if => :check_circle, :allow_destroy => true
	has_many :roles
	accepts_nested_attributes_for :roles, :allow_destroy => true


	private
	def check_circle(circle_attr)
		if _circle = Circle.find(circle_attr['name'])
	    	self.circles << _circle
	    	return true
	   	end
	    return false
	end
end
