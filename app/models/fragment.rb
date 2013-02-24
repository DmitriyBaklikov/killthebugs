class Fragment < ActiveRecord::Base

  validates_presence_of :code, :user_id, :language
  validates_uniqueness_of :title, :scope => :user_id
  validates_uniqueness_of :hashie

  attr_accessible :code, :has_bugs, :is_public, :title, :language
  has_many :sharings
  has_many :users, :through => :sharings
  belongs_to :author, class_name: "User", foreign_key: :user_id, inverse_of: :own_fragments

  before_create :auto_title
  after_create :create_hashie

  # strip useless symbols that browsers may send
  def code=(val)
    write_attribute(:code, val.delete("\r"))
  end

  private

  def auto_title
    if title.blank?
      self.title = code.lines.first
    end
  end

  def create_hashie
    self.hashie = SecureRandom.hex(16)
    self.save!
  end
end
