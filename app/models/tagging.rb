class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :book
  # attr_accessible :title, :body
end
