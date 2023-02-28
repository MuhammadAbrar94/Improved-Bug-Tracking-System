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
    # Define abilities for the user here. For example:
    #
    #   return unless user.present?
    #   can :read, :all
    #   return unless user.admin?
    #   can :manage, :all
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
  end
end
