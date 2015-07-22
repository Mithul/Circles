class Checklist < ActiveRecord::Base
  belongs_to :circle
  belongs_to :user
  has_many :checklist_items
  accepts_nested_attributes_for :checklist_items, :allow_destroy => true

end
