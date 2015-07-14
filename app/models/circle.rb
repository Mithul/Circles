class Circle < ActiveRecord::Base
  
  extend FriendlyId
  friendly_id :name,  use: [:slugged, :finders]

  belongs_to :circle
  has_many :circles
  has_and_belongs_to_many :members
  has_many :roles
  has_many :comments, as: :post
  
  accepts_nested_attributes_for :roles, :allow_destroy => true
  accepts_nested_attributes_for :members, :reject_if => :check_member, :allow_destroy => true


  def main_circles
  	self.circles.where(:category => 'main')
  end

  def task_title
    'Circle "'+self.name+'" was created'
  end

  def task_date
    self.created_at 
  end

  def task_category
    'Circle' 
  end

  def description
    'Circle was created with ' + member_names + 'member(s) and ' + circle_names + ' circle(s) under it.'
  end

  def member_names
    return self.members.pluck(:name).join(', ')
    ' 0' if self.members.count == 0
  end

  def circle_names
    return self.circles.pluck(:name).join(', ')
    ' 0' if self.circles.count == 0
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
