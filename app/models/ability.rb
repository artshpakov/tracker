class Ability
  include CanCan::Ability

  def initialize(user)
    return false unless user.present?

    can :read, Issue

    if user.is_a? Regular
      can :create, Issue
      can :update, Issue, reporter_id: user.id
      can :destroy, Issue, reporter_id: user.id
      cannot :update_status, Issue
      cannot :update_assignee, Issue
    end

    if user.is_a? Manager
      cannot :create, Issue
      can :update, Issue, assignee_id: [nil, user.id]
      can :update_status, Issue, assignee_id: user.id
      can :update_assignee, Issue, assignee_id: [nil, user.id]
    end
  end
end
