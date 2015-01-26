class User
  include Mongoid::Document

  has_many :exams

  field :username, type: String
  field :first_name, type: String
  field :last_name, type: String
  field :email, type: String
  field :photo_url, type: String
  field :biola_id, type: String
  field :affiliations, type: Array
  field :entitlements, type: Array

  validates :username, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :biola_id, presence: true, uniqueness: true

  def name
    "#{first_name} #{last_name}"
  end

  def relevant_entitlements
    urns = Array(entitlements)
    nids = Settings.urn_namespaces

    return [] if urns.blank?

    clean_urns = urns.map { |e| e.gsub(/^urn:/i, '') }
    clean_nids = nids.map { |n| n.gsub(/^urn:/i, '') }

    clean_urns.map { |urn|
      clean_nids.map { |nid|
        urn[0...nid.length] == nid ? urn[nid.length..urn.length] : nil
      }
    }.flatten.compact
  end

  def has_role?(*roles)
    (self.roles & roles).any?
  end

  def roles
    (Array(affiliations) + relevant_entitlements).map(&:to_sym)
  end

  def admin?
    has_role?(:admin) || developer?
  end

  def developer?
    has_role?(:developer)
  end

end
