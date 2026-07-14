class CompanyPolicy < ApplicationPolicy

  def index?
    %w(ceo).include? user.role
  end

  def create?
    index?
  end

  def update?
    index?
  end

  def edit_modal?
    index?
  end

  def new_modal?
    index?
  end

  def show?
    # index?
    true
  end

end