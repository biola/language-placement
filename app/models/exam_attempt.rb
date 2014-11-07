class ExamAttempt
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  belongs_to :exam_type

  field :uid, type: String
  field :started_at, type: DateTime
  field :completed_at, type: DateTime
  field :score, type: Integer
  
end