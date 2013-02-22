class Fragment < ActiveRecord::Base
  
  validates_uniqueness_of :title, :scope => :user_id
  validates_uniqueness_of :hashie

  attr_accessible :code, :has_bugs, :is_public, :title, :language
  has_many :sharings
  has_many :users, :through => :sharings
  
  after_create :create_hashie


  def create_hashie
    self.hashie = SecureRandom.hex(16)
    number = 1
    code_with_lines = ""
    self.code.lines.each do |line|
      if number < 10
        prefix = "00"
      elsif number > 9 and number < 100
        prefix = "0"
      else
        prefix = ""
      end

      code_with_lines += prefix + number.to_s + line
      number += 1
    end
    self.code = code_with_lines
    self.save
  end

end
