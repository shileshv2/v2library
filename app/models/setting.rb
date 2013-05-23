class Setting < ActiveRecord::Base
  attr_accessible :no_of_days
  validates :no_of_days, :presence => true , :allow_blank => true

end
