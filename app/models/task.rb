# == Schema Information
# Schema version: 20110221221644
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
#

class Task < ActiveRecord::Base
end
