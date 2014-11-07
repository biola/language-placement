class Exam
  include Mongoid::Document

  belongs_to :exam_type
  belongs_to :user

  embeds_many :exam_attempts
end