class UserPolicy < ApplicationPolicy

  def index?
    %w(ceo director).include? user.role
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
    self.user == self.record || index?
  end

end