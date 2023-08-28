module EstoqueInsHelper
  def cria_despesa(estoque_in)
    CashOut.create!(
      description: "Compra de Produto - #{estoque_in.produto.descricao}",
      category: 'Estoque',
      value: estoque_in.preco_compra,
      method: 'Dinheiro',
      expiration: Date.today,
      payment_date: Date.today,
      supplier: estoque_in.supplier.description
    )
  end

  def entrada(produto, quantidade)
    p = Produto.find(produto)
    entrada = p.quantidade + quantidade
    p.quantidade = entrada
    p.save!
  end
end
