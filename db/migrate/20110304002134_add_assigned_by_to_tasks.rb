class AddAssignedByToTasks < ActiveRecord::Migration
  def self.up
    add_column :tasks, :assigned_by, :integer
  end

  def self.down
    remove_column :tasks, :assigned_by
  end
end
