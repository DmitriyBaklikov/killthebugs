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

  after_create :initialize_settings

  private

  def initialize_settings
    self.settings ||= { default_language: "ruby" }
    self.save!
  end
end
