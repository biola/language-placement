require 'securerandom'
require 'net/http'
require 'uri'
require 'csv'

class Attempt
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :exam

  field :uid, type: String
  field :started_at, type: DateTime
  field :completed_at, type: DateTime
  field :score, type: Integer

  validates :uid, presence: true

  before_validation :set_uid, on: :create
  before_validation :set_started_at, on: :create

  def set_uid
    self.uid = SecureRandom.hex(16)
  end

  def set_started_at
    self.started_at = Time.zone.now
  end

  def to_s
    started_at.to_s
  end

  def unfinished?
    completed_at.nil?
  end

  def import_score!
    url = ExamUrlGenerator.new(uid, exam.type_code).results_url
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    csv = CSV.new(response.body, headers: true)
    row = csv.first

    self.completed_at = DateTime.parse(row['end'])
    self.started_at = DateTime.parse(row['start'])
    self.score = row['score']

    self.save!
  end

  scope :unfinished, -> { where :completed_at => nil }
  scope :finished, -> { where :completed_at.ne => nil }
  scope :started_at_desc, -> { order_by(:started_at => :desc) }
  scope :completed_at_desc, -> { order_by(:completed_at => :desc) }

  delegate :type_code, to: :exam, prefix: true
  delegate :type_name, to: :exam, prefix: true
  delegate :user_username, to: :exam, prefix: true
  delegate :user_name, to: :exam, prefix: true
  delegate :user_biola_id, to: :exam, prefix: true
  delegate :user_email, to: :exam, prefix: true
end
