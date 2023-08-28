# Model que representa o estoque
class Produto < ApplicationRecord
  has_one :tributo
  accepts_nested_attributes_for :tributo, allow_destroy: true
 
  enum categoria: %w[Cervejas Sucos Refrigerantes Salgados Doces Agua Isotonicos]
  validates_length_of :descricao, minimum: 3, maximum: 30, allow_blank: false, message: "precisa ter entre 3 e 30 caracteres"
  validates_presence_of :descricao, :preco_venda, :quantidade, :categoria
  monetize :preco_compra_cents
  monetize :preco_venda_cents

  # Cria uma saida de estoque
  def self.saida(produto, quantidade, user, controller = nil)
    p = Produto.find(produto)

    return if p.quantidade < quantidade

    saida = p.quantidade - quantidade
    p.update(quantidade: saida)

    EstoqueOut.create!(produto_id: produto, quantidade: quantidade, user_id: user, origem: 'Comanda') if controller == 'comandas'
  end

  # Metodo responsável por registrar uma quebra, saída de estoque e despesa
  def self.quebra(produto, quantidade, origem = 'Quebra', admin)
    p = Produto.find(produto)

    saida(produto, quantidade, admin)

    Despesa.create!(
      data_saida: Date.today,
      origem: origem,
      valor: p.preco_compra
    )
  end
end