# frozen_string_literal: true

# This class represents a particular ability that a character can have in a bug like Manager/QA/Developer.
# Abilities can have various properties such as a name, description, and power level.
# This class provides methods for creating and modifying abilities, as well as for
# querying their properties.
class Ability
  include CanCan::Ability
  def initialize(user)
    if user.manager?
      can :manage, Project, user_id: user.id
      can :manage, Assign
      can :read, Report
    elsif user.qa? || user.developer?
      can :read, Project
      can :manage, Report, creator_id: user.id if user.qa?
      can :manage, Report, developer_id: user.id if user.developer?
    end
  end
end
