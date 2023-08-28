class Team < ApplicationRecord
  acts_as_paranoid

  belongs_to :cliente
  belongs_to :plano, optional: true
  belongs_to :modalidade
  has_one :team_account
  has_many :mensalidades

  after_create :create_account
  before_destroy :remove_team_account

  include TeamsHelper

  def inativar
    update(ativo: false)
  end

  private

  def create_account
    build_team_account.save
  end

  def remove_team_account
    raise 'O time possui mensalidades na conta-corrente.' if mensalidades.present?

    team_account.delete
  end
end
