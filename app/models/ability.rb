# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Post, public: true

    return if user.blank?

    can :read, Post, user:
  end
end
