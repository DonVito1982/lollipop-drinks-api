class Session < ApplicationRecord
  belongs_to :user

  DEFAULT_MINS = 30
end
