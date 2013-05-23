class Book < ActiveRecord::Base
  attr_accessible :author, :description, :edition,:isbn, :tag_list,:location_id,:status,
  				        :price, :publisher, :purchased_at, :title, :user_id

  belongs_to :location
  belongs_to :user
  has_many :taggings
  has_many :tags, through:  :taggings
  has_many :transactions

  validates :author, :edition, :isbn, :price, :publisher, :presence => true
  validates :title, :presence => true 

  after_create :update_book_status

  STATUS = { :in => 1, :out => 2, :not_available => 3 }

    
  def self.search(search)
    if search
       @books = Book.find(:all, :conditions => ["title LIKE ?","%#{search}%" ])
    #   #raise @bookdetail.inspect
     else
       @book = Book.all
     end
  end




  def change_status
    #raise params.inspect
    self.update_attribute(:status, Book::STATUS[:in])
  end 

  def self.tagged_with(name)
  	Tag.find_by_name!(name).books
  end

  def self.tag_counts
    	Tag.select("tags.*, count(taggings.tag_id) as count").joins(:taggings).group("taggings.tag_id")
  end

  def tag_list
    tags.map(&:name).join(", ")
  end

  def tag_list=(names)
  	 self.tags = names.split(",").map do |n|
    	 Tag.where(name: n.strip).first_or_create!
    end
  end
end
