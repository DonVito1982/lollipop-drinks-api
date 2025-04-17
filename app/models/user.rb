class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :user_drinks

  validates :username, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  MAX_DAILY_CAFFEINE = 500

  def recent_drinks
    user_drinks.where("created_at > ?", 1.day.ago)
  end

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

  def caffeine_status
    recent_caffeine = recent_drinks.reduce(0) do |sum, user_drink|
      sum += user_drink.drink.serv_count * user_drink.drink.serv_caffeine
    end
    { last_day: recent_caffeine, left: MAX_DAILY_CAFFEINE - recent_caffeine }
  end
end
