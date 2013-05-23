class Book < ActiveRecord::Base
  attr_accessible :author, :description, :edition,:isbn, :tag_list,:location_id,:status,
  				        :price, :publisher, :purchased_at, :title, :user_id

  belongs_to :location
  belongs_to :user
  has_many :taggings
  has_many :tags, through:  :taggings
  has_many :transactions
  
  validates :title, :presence => true, :format => { :with => /^(?:[^\W_]|\s)*$/u }, :allow_blank => true
     
  validates :author, :presence => true, :format => { :with => /[A-Za-z]+/, :message => " is invalid , Only letters are allowed" } , :allow_blank => true
  
  validates :edition, :presence => true,  :format => { :with => /^(?:[^\W_]|\s)*$/u }, :allow_blank => true
  
  validates :isbn,  :presence => true,:numericality => true, :uniqueness => true, :allow_blank => true
  validates :publisher, :presence => true, :format => { :with => /[A-Za-z]+/, :message => " is invalid , Only letters  are allowed" }, :allow_blank => true
  validates :price, :presence => true 
  validates :purchased_at, :presence => true

  ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  if html_tag =~ /\<label/
    html_tag
  else
    errors = Array(instance.error_message).join(',')
    %(#{html_tag}<span class="validation-error">&nbsp;#{errors}</span>).html_safe
  end
end

  after_create :change_status

  STATUS = { :in => 1, :out => 2, :not_available => 3 }

    
  def self.search(search)
    if search
       @books = Book.find(:all, :conditions => ["title LIKE ?","%#{search}%" ])
     else
       @book = Book.all
     end
  end

 def change_status
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
