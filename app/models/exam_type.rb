class ExamType
  include Mongoid::Document

  has_many :exams

  field :name, type: String
  field :code, type: String

  validates :name, :code, presence: true, uniqueness: true

end