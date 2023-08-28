module InvoicesHelper

  def info_item_comanda(item)
    {
      "codigo": item.produto.id,
      "descricao": item.produto.descricao,
      "ncm": item.produto.tributo.ncm,
      "cfop": item.produto.tributo.cfop,
      "unidade_comercial": 'UN',
      "quantidade_comercial": item.quantidade,
      "valor_unitario_comercial": item.valor_cents,
      "impostos": {
        "icms": {
          "origem": 0,
          "cst": '41',
          "csosn": '400'
        },
        "pis": {"cst": '01'},
        "cofins": {"cst": '01'}
      }
    }
  end

  def produtos_nf comanda
    comanda.itens_comandas.map { |item| info_item_comanda(item) }
  end

end
