class TeamAccount < ApplicationRecord
  acts_as_paranoid
  
  belongs_to :team

  monetize :balance_cents

  after_touch :atualiza_saldo

  def atualiza_saldo
    mensalidades = Mensalidade.where(team:, status: ['Em aberto', 'Em atraso'])
    valor_pago = mensalidades.sum(:valor_pago_cents)
    saldo = mensalidades.where('vencimento <= ?', Date.today).where.not(status: 'Pago').sum(:value_cents)

    update(balance_cents: valor_pago - saldo)
  end
end
