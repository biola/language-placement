class Exam
  include Mongoid::Document

  belongs_to :exam_type
  belongs_to :user

  embeds_many :exam_attempts

  delegate :code, to: :exam_type, prefix: true

  validates :exam_type, :user, presence: true
  validates :user, uniqueness: { scope: :exam_type }

  scope :unfinished, -> { where :"exam_attempts.completed_at" => nil }
  scope :finished, -> { where :"exam_attempts.completed_at".ne => nil }
end