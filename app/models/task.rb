class Task < ActiveRecord::Base
  default_scope :order => 'tasks.name ASC'
end
