# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  class Scope < Scope
  end

  def create?
    user.id != record.product.user_id
  end

  def new?
    create?
  end
end
