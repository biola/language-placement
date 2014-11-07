require 'securerandom'

class ExamAttempt
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :exam

  field :uid, type: String
  field :started_at, type: DateTime
  field :completed_at, type: DateTime
  field :score, type: Integer

  validates :uid, presence: true

  before_validation :set_uid, on: :create

  def set_uid
    self.uid = SecureRandom.hex(16)
  end
  
end