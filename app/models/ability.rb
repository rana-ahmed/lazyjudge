class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      if user.admin?
        can :manage, User
        can :manage, Problem
        can :manage, 'admin/contest'
        can [:read, :destroy], Clarification
      elsif user.judge?
        can :read, Problem
        can [:read, :update], Clarification
      elsif user.team?
        can :read, Problem
        can [:read, :create], Clarification
      end
    else
      can :read, :all
    end
  end
end
