class UserDrinksController < ApplicationController
  # GET /user_drinks
  def index
    @user_drinks = UserDrink.recent_drinks(current_user)

    render json: @user_drinks
  end

  # POST /user_drinks
  def create
    @user_drink = UserDrink.create(user_drink_params.merge(user: current_user))

    if @user_drink.save
      render json: @user_drink, status: :created
    else
      render json: @user_drink.errors, status: :unprocessable_entity
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def user_drink_params
      params.permit(:drink_id)
    end
end
