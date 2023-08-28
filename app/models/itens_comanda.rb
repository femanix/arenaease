class ItensComanda < ApplicationRecord
  belongs_to :comanda
  belongs_to :produto

  monetize :valor_cents

  after_save :atualizar_valor_total
  after_destroy :atualizar_valor_total
  before_save :valor_item

  def self.total
    sum(:valor)
  end

  def valor_item
    valor = Produto.find(produto_id).preco_venda
    self.valor = valor * quantidade
  end

  def atualizar_valor_total
    comanda.calcular_valor_total # chama o método calcular_valor_total da comanda
  end
end
