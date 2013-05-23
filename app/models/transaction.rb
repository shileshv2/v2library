class Transaction < ActiveRecord::Base
  attr_accessible :book_id, :employee_email,:employee,:employee_name,:transaction_date, :transaction_type, :user_id
  belongs_to :book
  belongs_to :user
  

  validates :employee_email , :presence => true,   :uniqueness => true,   
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i , :message => "email entered is not in a valid format" } , :allow_blank => true

    validates :employee , :presence => true
    validates :employee_name , :presence => true , :format => { :with => /[A-Za-z]+/, :message => "Only letters are allowed" } , :allow_blank => true   
    validates :transaction_date , :presence => true     

  after_create :change_status

  TRANSACTION_TYPE = { :issue => 1, :return => 2 }

  def change_status
  	if transaction_type == TRANSACTION_TYPE[:issue]
  		book.update_attribute(:status,Book::STATUS[:out])
  	else
  		book.update_attribute(:status,Book::STATUS[:in])
  	end	
 end
end
  