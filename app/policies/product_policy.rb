# frozen_string_literal: true

class ProductPolicy < ApplicationPolicy
  class Scope < Scope
  end

  def create?
    user.nil? || user.id != record.user_id
  end

  def destroy?
    user.id == record.user_id
  end

  def edit?
    user.id == record.user_id
  end

  def update?
    edit?
  end

  def show?
    !edit?
  end
end
