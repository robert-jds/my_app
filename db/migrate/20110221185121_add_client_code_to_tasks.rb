class AddClientCodeToTasks < ActiveRecord::Migration
  def self.up
    add_column :tasks, :client_code, :string
  end

  def self.down
    remove_column :tasks, :client_code
  end
end
