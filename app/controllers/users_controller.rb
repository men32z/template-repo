# Handle all users pages and realted.
class UsersController < ApplicationController
  def index
    page = params[:page].blank? ? 1 : params[:page]
    @params = { status: params[:status] }

    @status = UserStatus.all.collect { |a| [a.name.capitalize, users_path({ status: a.id })] }
    @status.unshift ['All', users_path({ status: 0 })]

    @users = User.page(page).where_status(params[:status]).per(10).order(:id)
  end

  def show
    @user = User.find_by(id: params[:id])
    return if @user

    flash.now[:danger] = 'user not found'
    redirect_to root_path
  end
end
