class Role < ActiveRecord::Base
  belongs_to :circle
  belongs_to :member

  def parent
  	if self.member
  		return self.member
  	end
  	self.circle
  end

end
