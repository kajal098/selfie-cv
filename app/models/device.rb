class Device < ActiveRecord::Base
  
  belongs_to :user

  validates :uuid, :token, presence: true

  #scope :active, -> {where.not(registration_id: nil, user_id: nil)}

  validates :registration_id,presence: true, uniqueness: { case_sensitive: false }

  before_validation :renew_token, if: -> { token.blank? }

  def renew_token
    self.token = SecureRandom.uuid
  end

  def ensure_duplicate_registrations
    self.class.where(registration_id: registration_id).where.not(id: id).update_all(registration_id: nil)
  end

  
end

