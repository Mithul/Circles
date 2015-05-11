class Circle < ActiveRecord::Base
  belongs_to :circle
  has_many :circles
  has_and_belongs_to_many :members

end
