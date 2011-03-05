class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.string :name
      t.datetime :due_date

      t.timestamps
    end
    add_index :tasks, :assigner_id
    add_index :tasks, :assignee_id
  end

  def self.down
    drop_table :tasks
  end
end
