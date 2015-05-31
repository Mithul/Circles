class Circle < ActiveRecord::Base
  
  belongs_to :circle
  has_many :circles
  has_and_belongs_to_many :members
  has_many :roles
  accepts_nested_attributes_for :roles, :allow_destroy => true


end
