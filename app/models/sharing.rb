class Sharing < ActiveRecord::Base

  attr_accessible :user_id, :fragment_id

  validates_uniqueness_of :fragment_id, :scope => :user_id
  
  belongs_to :user
  belongs_to :fragment

end
