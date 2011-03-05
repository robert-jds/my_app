# == Schema Information
# Schema version: 20110304002134
#
# Table name: tasks
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  due_date    :datetime
#  created_at  :datetime
#  updated_at  :datetime
#  description :string(255)
#  task_code   :string(255)
#  user_id     :integer
#  assigned_to :integer
#  assigned_by :integer
#

class Task < ActiveRecord::Base
  attr_accessible :name, :due_date, :description, :task_code, :assigned_to

  belongs_to :assigner_id, :class_name => "User", :foreign_key => "user_id"
  belongs_to :assignee_id, :class_name => "User", :foreign_key => "user_id"

  validates :name, :presence => true
  validates :description, :presence => true
  validates :assigned_to, :presence => true
  # validates :due_date, :presence => true

  default_scope :order => 'tasks.created_at DESC'
end
