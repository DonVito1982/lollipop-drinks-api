class DrinksController < ApplicationController
  def index
    render json: Drink.all
  end

  def status
    response = { caffeine_status: current_user.caffeine_status }
    render json: response, status: :ok
  end
end
