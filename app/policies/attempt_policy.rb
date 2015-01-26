class AttemptPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user_id: user.id)
      end
    end
  end

  def show?
    user.admin? || user.has_role?(:student)
  end

  alias :create?, :show?
  alias :complete?, :show?
end
