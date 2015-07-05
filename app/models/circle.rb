class Circle < ActiveRecord::Base
  
  extend FriendlyId
  friendly_id :name,  use: [:slugged, :finders]

  belongs_to :circle
  has_many :circles
  has_and_belongs_to_many :members
  has_many :roles
  accepts_nested_attributes_for :roles, :allow_destroy => true
  accepts_nested_attributes_for :members, :reject_if => :check_member, :allow_destroy => true


  def main_circles
  	self.circles.where(:category => 'main')
  end


  private
	def check_member(member_attr)
		if _member = Member.find(member_attr['name'])
	    	self.members << _member
	    	return true
	   	end
	    return false
	end
end
