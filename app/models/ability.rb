# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Post
    can :read, Comment

    return unless user.present?

    can [:read, :destroy], Post, author_id: user.id
    can [:read, :destroy], Comment, author_id: user.id
    can :destroy, Post if user.admin?
    can :destroy, Comment if user.admin?
  end
end
