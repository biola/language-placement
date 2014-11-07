class ExamType
  include Mongoid:Document

  has_many :exam_attempts

  field :name, type: String
  field :code, type: String
end