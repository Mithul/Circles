class Role < ActiveRecord::Base
  belongs_to :circle
  has_and_belongs_to_many :members
  has_many :comments, as: :post
  

  def parent
  	if self.members
  		return self.members
  	end
  	self.circle
  end

  def circle_name
  	self.circle.name if self.circle
  end

  def task_title
    entity = self.circle.name if self.circle and self.members.count == 0
    entity = self.members.first.name if self.members and self.members.count == 1
    entity = self.members.pluck(:name).join(', ') if self.members and self.members.count > 1

    'Role "'+self.name+'" assigned to ' + entity if entity
  end

  def task_date
    self.created_at 
  end

  def task_category
    'Role' 
  end

end
