# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return if user.blank?

    if user.is_a? User
      can :read, Post, public: true
      can :read, Post, user:
    elsif user.is_a? AdminUser
      can :read, ActiveAdmin::Page, name: 'Dashboard', namespace_name: 'admin'
      can :manage, AdminUser
    end
  end
end
