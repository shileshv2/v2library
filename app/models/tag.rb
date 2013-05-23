class Tag < ActiveRecord::Base
  attr_accessible :name
  has_many :taggings
  has_many :books, through: :taggings
  validates :name, :presence => true , :allow_blank => true 
end
