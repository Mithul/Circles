class Task < ActiveRecord::Base
  belongs_to :circle
  has_many :comments, as: :post

  def task_date
  	self.created_at
  end

  def task_title
  	self.title
  end

   def task_category
  	self.category
  end

end
