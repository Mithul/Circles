class ChecklistItem < ActiveRecord::Base
  belongs_to :checklist
  belongs_to :user
end
