class Session < ApplicationRecord
  belongs_to :user

  DEFAULT_MINS = 120
end
