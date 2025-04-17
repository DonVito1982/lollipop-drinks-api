class UserDrinksController < ApplicationController
  # GET /user_drinks
  def index
    @user_drinks = current_user.recent_drinks

    render json: @user_drinks
  end

  # POST /user_drinks
  def create
    @user_drink = current_user.user_drinks.create(user_drink_params)

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
