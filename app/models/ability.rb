# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Recibo

    return unless user.present?

    can %i[read create update], Comanda
    can(:manage, User, user:)

    return unless user.super_admin?

    can :manage, :all
  end
end
