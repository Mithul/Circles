class Role < ActiveRecord::Base
  belongs_to :circle
  belongs_to :member

  def parent
  	if self.member
  		return self.member
  	end
  	self.circle
  end

  def circle_name
  	self.circle.name
  end

end
