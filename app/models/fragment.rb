class Fragment < ActiveRecord::Base

  validates_uniqueness_of :title, :scope => :user_id
  validates_uniqueness_of :hashie

  attr_accessible :code, :has_bugs, :is_public, :title, :language
  has_many :sharings
  has_many :users, :through => :sharings

  before_create :auto_title
  after_create :create_hashie

  private

  def auto_title
    if title.blank?
      self.title = code.lines.first
    end
  end

  def create_hashie
    self.hashie = SecureRandom.hex(16)
    self.save
  end
end
