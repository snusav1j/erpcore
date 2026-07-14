class ClientPolicy < ApplicationPolicy

  def index?
    %w(ceo director manager).include? user.role
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
    true
  end

  def edit?
    true
  end

  def destroy?
    %w(ceo director).include? user.role
  end

end