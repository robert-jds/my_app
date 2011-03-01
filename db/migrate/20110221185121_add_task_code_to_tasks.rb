class AddTaskCodeToTasks < ActiveRecord::Migration
  def self.up
    add_column :tasks, :task_code, :string
  end

  def self.down
    remove_column :tasks, :task_code
  end
end
