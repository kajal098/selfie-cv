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

  def self.notify(devices, data={})
      alert = data.delete(:alert).to_s[0..40] if data[:alert]
      sound = data.delete(:sound) if data[:sound]
      devices.each do |device|
        n = Rpush::Gcm::Notification.new
        n.app = Rpush::Gcm::App.find_by_name("android_app")
        n.registration_ids = device.registration_id
        n.device_token = device.id
        n.data = data
        n.priority = 'high'
        n.save!
        puts "notification to #{device.registration_id}"
        puts "#{n}"
      end
  end

  def self.notification(devices, data={})
    alert = data.delete(:alert).to_s[0..40] if data[:alert]
    sound = data.delete(:sound) if data[:sound]
    devices.each do |device|
      n = Rpush::Apns::Notification.new
      n.app = Rpush::Apns::App.find_by_name("ios")
      n.device_token = device.registration_id
      n.badge = "1"
      n.alert = alert unless alert.nil?
      n.sound = sound unless sound.nil?
      n.data = data
      n.content_available = !data.blank?
      n.save!
    end
  end

  
end

