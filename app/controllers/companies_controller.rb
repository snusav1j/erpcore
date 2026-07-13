class CompaniesController < ApplicationController
  before_action :get_columns, only: [:index, :create, :update]

  def index
    @companies = Company.all
  end

  def show
    @company = Company.find(params[:id])
  end

  def new_modal
    @company = Company.new
    respond_to :js
  end

  def edit_modal
    @company = Company.find(params[:id])
    respond_to :js
  end

  def create
    @company = Company.new(company_params)
    @company.manager_id = current_user.id
    @created = @company.save

    @companies = Company.all
    respond_to :js
  end

  def update
    @company = Company.find(params[:id])
    @updated = @company.update(company_params)

    @companies = Company.all
    respond_to :js
  end

  def destroy
    @company = Company.find(params[:id])
    @destroyed = @company.destroy

    @companies = Company.all
    respond_to :js
  end

  private

  def get_columns
    @columns = Company.table_columns
  end

  def company_params
    params.require(:company).permit!
  end
end