class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      if user.admin?
        can :manage, User
        can :manage, Problem
        can :manage, 'admin/contest'
        can [:read, :destroy], Clarification
        can [:read], Submission
      elsif user.judge?
        can :read, Problem
        can [:read, :update], Clarification
        can [:read, :update], Submission
      elsif user.team?
        can :read, Problem
        can [:read, :create], Clarification
        can [:read, :create], Submission
      end
    else
      can :read, :all
    end
  end
end
