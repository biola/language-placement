class Exam
  include Mongoid::Document

  belongs_to :type
  belongs_to :user

  embeds_many :attempts

  delegate :code, to: :type, prefix: true
  delegate :username, to: :user, prefix: false

  validates :type, :user, presence: true
  validates :user, uniqueness: { scope: :type }

  scope :unfinished, -> { where :"attempts.completed_at" => nil }
  scope :finished, -> { where :"attempts.completed_at".ne => nil }
end
