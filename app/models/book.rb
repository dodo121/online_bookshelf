class Book
  include Mongoid::Document
  include Mongoid::Paperclip
  field :name, type: String
  field :author, type: String
  validates_presence_of :name, :author
  has_mongoid_attached_file :cover, :styles => { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/none"
  validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/
  has_and_belongs_to_many :users
end