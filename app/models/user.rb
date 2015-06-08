# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string
#  email                  :string
#  password_digest        :string
#  admin                  :boolean          default(FALSE)
#  clinician              :boolean          default(FALSE)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  practice_id            :string
#  password_reset_token   :string
#  password_reset_sent_at :datetime
#  super_user             :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  has_secure_password
  has_many :patients
   has_many :appointments
  belongs_to :practice

  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                  format: { with: VALID_EMAIL_REGEX },
                  uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, allow_blank: true
  validates_presence_of :practice

  delegate :name, to: :practice, prefix: true

  def self.find_local_clinicians(current_user)
    self.where(practice_id: current_user.practice_id).where(clinician: true)
  end

  def self.all_with_practice
    includes(:practice).order(:practice_id)
  end

  def feed
    self.patients.where(questionnaire_complete: true).where("appointment_time > ?", 1.days.ago).order(:appointment_time)
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save
    UserMailer.password_reset(self).deliver_now
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end
