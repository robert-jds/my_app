class AddPriorityToTasks < ActiveRecord::Migration
  def self.up
    add_column :tasks, :priority, :integer, :default => 1
  end

  def self.down
    remove_column :tasks, :priority
  end
end
