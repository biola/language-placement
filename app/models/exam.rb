class Exam
  include Mongoid::Document

  belongs_to :exam_type
  belongs_to :user

  embeds_many :exam_attempts

  delegate :code, to: :exam_type, prefix: true

  validates :exam_type, :user, uniqueness: true, presence: true
end