# Handle all users pages and realted.
class UsersController < ApplicationController
  def index
    page = params[:page].blank? ? 1 : params[:page]
    @params = {}
    @users = User.page(page).per(3).order(:id)
    return if params[:active].blank?

    @users = @users.where(status_id: params[:active])
    @params[:active] = params[:active]
  end

  def show
    @user = User.find_by(id: params[:id])
    return if @user

    flash.now[:danger] = 'user not found'
    redirect_to root_path
  end
end
