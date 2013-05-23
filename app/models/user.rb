class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :employee_id, :location_id
  validates :employee_id, :presence => true
  validates	:location_id, :presence => true
  # attr_accessible :title, :body
  belongs_to :location
  has_many   :transactions
end
