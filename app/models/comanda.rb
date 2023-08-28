class Comanda < ApplicationRecord
  belongs_to :cliente, inverse_of: :comandas
  has_many :itens_comandas, dependent: :delete_all
  has_one :invoice
  accepts_nested_attributes_for :itens_comandas, reject_if: proc { |attributes|
                                                              attributes['produto_id'].blank?
                                                            }, allow_destroy: true

  enum status: %i[aberta encerrada]

  scope :encerradas, -> { where(status: 1) }
  scope :abertas, -> { where(status: 0) }

  monetize :valor_total_cents

  include ComandasHelper

  def encerrar(forma)
    update(status: 1)
    cash_in(self, forma)
  end

  def total
    ItensComanda.where(comanda_id: id).total
  end

  def calcular_valor_total
    valor_total = itens_comandas.sum(:valor_cents) # soma o valor de todos os itens da comanda
    update_column(:valor_total_cents, valor_total) # atualiza o valor_total na tabela de comandas
  end
end
