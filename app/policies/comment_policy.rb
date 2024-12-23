# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def create?
    user.id != record.product.user_id
  end

  def new?
    create?
  end
end
