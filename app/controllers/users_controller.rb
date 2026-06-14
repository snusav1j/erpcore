class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new_modal
    @user = User.new
    respond_to :js
  end

  def edit_modal
    @user = User.find(params[:id])
    respond_to :js
  end

  def create
    @user = User.new(user_params)
    @created = @user.save

    @users = User.all
    respond_to :js
  end

  def update
    @user = User.find(params[:id])
    @updated = @user.update(user_params)

    @users = User.all
    respond_to :js
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    @users = User.all
    respond_to :js
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :role)
  end

end