# == Schema Information
# Schema version: 20110308234926
#
# Table name: comments
#
#  id         :integer         not null, primary key
#  task_id    :integer
#  user_id    :integer
#  comment    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Comment < ActiveRecord::Base
  attr_accessible :comment, :task_id

  belongs_to :user
  belongs_to :task

  validates :user_id, :presence => true
  validates :task_id, :presence => true
end
