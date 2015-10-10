class AddTimeToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :from, :datetime
    add_column :tasks, :to, :datetime
    add_column :tasks, :task_id, :integer
  end
end
