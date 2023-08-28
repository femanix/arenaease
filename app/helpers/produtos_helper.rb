module ProdutosHelper

    def to_csv(produtos)
    CSV.generate(headers: true) do |csv|
      csv << ['ID', 'Descricao', 'Preco de Compra', 'Preco de Venda', 'Data de Validade', 'Quantidade', 'Categoria']

      produtos.each do |produto|
        csv << [
                produto.id, 
                produto.descricao, 
                produto.preco_compra, 
                produto.preco_venda, 
                produto.data_validade, 
                produto.quantidade, 
                produto.categoria
              ]
      end
    end
  end
end
