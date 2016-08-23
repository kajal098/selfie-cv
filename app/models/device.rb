class Device < ActiveRecord::Base
  
  belongs_to :user

  validates :uuid, :token, presence: true

  #scope :active, -> {where.not(registration_id: nil, user_id: nil)}

  before_validation :renew_token, if: -> { token.blank? }

  paginates_per 10

  def renew_token
    self.token = SecureRandom.uuid
  end

  def ensure_duplicate_registrations
    self.class.where(registration_id: registration_id).where.not(id: id).update_all(registration_id: nil)
  end

  
end

