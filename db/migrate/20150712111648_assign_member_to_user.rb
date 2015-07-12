class AssignMemberToUser < ActiveRecord::Migration
  def change
    add_column :members, :user_id, :integer
    add_column :members, :category, :integer
  end
end
