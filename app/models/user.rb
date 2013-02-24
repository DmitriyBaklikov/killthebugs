class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  has_many :sharings
  has_many :fragments, :through => :sharings
  has_many :own_fragments, class_name: "Fragment", foreign_key: :user_id

  serialize :settings, ActiveRecord::Coders::Hstore

  validates :api_token, uniqueness: true

  after_create :initialize_settings

  def generate_api_token!
    self.api_token = SecureRandom.hex(16) + id.to_s
    self.save!
  end

  private

  def initialize_settings
    self.settings ||= { default_language: "ruby" }
    self.save!
  end
end
