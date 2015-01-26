class TypePolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      if admin?
        scope.all
      end
    end
  end

  def index?
    user.admin? || user.has_role?(:student)
  end
end
