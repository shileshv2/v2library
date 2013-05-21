class Book < ActiveRecord::Base
  attr_accessible :author, :description, :edition, :isbn, :location_id, :price, :publisher, :purchased_at, :status, :title, :user_id
end
