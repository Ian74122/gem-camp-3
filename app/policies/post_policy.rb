class PostPolicy < ApplicationPolicy
  def edit?
    record.user == user
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end

  def today?
    record.created_at.to_date == Date.current
  end
end