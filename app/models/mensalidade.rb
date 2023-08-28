class Mensalidade < ApplicationRecord
  acts_as_paranoid
  
  include MensalidadesHelper
  belongs_to :aluno, optional: true
  belongs_to :team, optional: true, touch: true
  belongs_to :plano
  has_one :recibo
  has_many :cash_ins

  monetize :value_cents
  monetize :valor_pago_cents

  enum status: ['Em aberto', 'Pago', 'Em atraso', 'Cancelada']

  after_update :touch_team_account

  after_find :altera_status

  attr_accessor :saldo

  def touch_team_account
    return unless team.present?

    team.team_account.touch
  end

  def self.em_aberto
    all.where(status: 'Em aberto')
  end

  def self.update_mensalidades
    em_aberto.each do |mensalidade|
      mensalidade.update(status: 'Em atraso') if mensalidade.vencimento.past?
    end
  end

  def altera_status
    return unless vencimento.past? && !saldo.zero?

    update(status: 'Em atraso')
  end

  def recibo
    Recibo.where(mensalidade: self)
  end

  def cancel
    update(status: 'Cancelada') if status == 'Em aberto' || status == 'Em atraso'
    Matricula.where(aluno_id: aluno.id).update(status: 1)
  end

  def saldo
    value - valor_pago
  end

  def atualiza_parcela_paga
    return unless saldo.zero?

    if data_pagamento.nil?
      update(status: 'Pago', data_pagamento: Date.today)
    else
      update(status: 'Pago')
    end
  end

  def estornar
    update(status: 0, data_pagamento: nil, valor_pago_cents: 0)
    cash_ins.destroy_all
  end
end
