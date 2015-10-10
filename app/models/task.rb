class Task < ActiveRecord::Base
  belongs_to :circle
  has_many :comments, as: :post

  belongs_to :task
  has_many :tasks

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
