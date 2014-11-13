class User
  include Mongoid::Document

  has_many :exams

  field :username, type: String
  field :first_name, type: String
  field :last_name, type: String
  field :email, type: String
  field :photo_url, type: String
  field :biola_id, type: String
  field :affiliations, type: Array
  field :entitlements, type: Array
  
  def name
    "#{first_name} #{last_name}"
  end

  validates :username, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :biola_id, presence: true, uniqueness: true
  
end