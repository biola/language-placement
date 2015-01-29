class Exam
  include Mongoid::Document

  belongs_to :type
  belongs_to :user

  embeds_many :attempts

  validates :type, :user, presence: true
  validates :user, uniqueness: { scope: :type }

  scope :unfinished, -> { where :"attempts.completed_at" => nil }
  scope :finished, -> { where :"attempts.completed_at".ne => nil }

  delegate :code, to: :type, prefix: true
  delegate :name, to: :type, prefix: true
  delegate :username, to: :user, prefix: true
  delegate :name, to: :user, prefix: true
  delegate :biola_id, to: :user, prefix: true
  delegate :email, to: :user, prefix: true
end
