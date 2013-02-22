class Fragment < ActiveRecord::Base
  
  validates_uniqueness_of :title, :scope => :user_id
  validates_uniqueness_of :hashie

  attr_accessible :code, :has_bugs, :is_public, :title, :language

  has_and_belongs_to_many :users
  
  after_create :create_hashie


  def create_hashie
    self.hashie = SecureRandom.hex(16)
    self.save
  end

end
