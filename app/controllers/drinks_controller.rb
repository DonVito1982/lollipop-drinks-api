class DrinksController < ApplicationController
  def index
    render json: Drink.all
  end

  def status
    user_recent_caffeine = UserDrink.recent_caffeine(current_user)
    left_caffeine = User::MAX_DAILY_CAFFEINE - user_recent_caffeine
    caffeine_status = { last_day: user_recent_caffeine, left: left_caffeine }
    drinks_left = Drink.caffeine_list.to_h do |drink_item|
      [ drink_item[:id], (left_caffeine / drink_item[:mg]).floor ]
    end
    response = { caffeine_status: caffeine_status, drinks_left: drinks_left }
    render json: response, status: :ok
  end
end
