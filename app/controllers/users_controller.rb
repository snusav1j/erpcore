class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:edit, :update]
  before_action :authorize_action

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
  
  def edit
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

    old_company_id = @user.company_id
    new_company_id = user_params[:company_id]

    # if old_company_id != new_company_id
    #   update_company_dependencies(old_company_id, new_company_id)
    # end

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

  def set_user
    @user = User.find(params[:id])
  end

  def authorize_action
    authorize @user || User
  end

  def user_params
    params.require(:user).permit!
  end

  # def update_company_dependencies(old_company_id, new_company_id)

  #   Client.where(company_id: old_company_id, manager_id: @user.id).update_all(company_id: new_company_id)

  #   Interaction.where(company_id: old_company_id, manager_id: @user.id).update_all(company_id: new_company_id)

  #   Order.where(company_id: old_company_id, manager_id: @user.id).update_all(company_id: new_company_id)

  #   Product.where(company_id: old_company_id).update_all(company_id: new_company_id)

  #   OrderItem.where(company_id: old_company_id).update_all(company_id: new_company_id)

  #   ClientType.where(company_id: old_company_id).update_all(company_id: new_company_id)

  #   ClientStatus.where(company_id: old_company_id).update_all(company_id: new_company_id)

  #   OrderStatus.where(company_id: old_company_id).update_all(company_id: new_company_id)

  #   InteractionType.where(company_id: old_company_id).update_all(company_id: new_company_id)

  #   InteractionStatus.where(company_id: old_company_id).update_all(company_id: new_company_id)

  # end

end