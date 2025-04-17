class User < ApplicationRecord
  has_secure_password
  has_many :sessions
  validates :username, uniqueness: true

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
