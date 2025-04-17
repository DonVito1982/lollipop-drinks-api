class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :user_drinks

  validates :username, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  MAX_DAILY_CAFFEINE = 500

  def alive_sessions
    sessions.where("expires_at > ?", Time.now)
  end

  def close_live_sessions
    alive_sessions.update_all(expires_at: Time.now)
  end

  def create_fresh_session
    close_live_sessions
    sessions.create(expires_at: Time.now + Session::DEFAULT_MINS.minutes)
  end
end
