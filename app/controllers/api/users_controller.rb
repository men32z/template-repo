module Api
  # Handle all users pages and realted.
  class UsersController < ApplicationController
    def index
      page = params[:page].blank? ? 1 : params[:page]
      @users = User.page(page).where_status(params[:status]).per(10).order(:id)
      render json: @users
    end

    def show
      @user = User.find_by(id: params[:id])
      return render json: @user if @user

      render json: { status: 404, message: 'user not found' }
    end
  end
end
