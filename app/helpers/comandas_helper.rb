module ComandasHelper
  def comandas_status(status = nil)
    case status
    when 'abertas', nil
      Comanda.includes(:cliente).abertas
    when 'encerradas'
      Comanda.includes(:cliente).encerradas
    else
      @comandas = Comanda.includes(:cliente).all
    end
  end

  def search_comanda(params)
    if params.key?(:status) && params.key?(:term)
      @comandas = Comanda.includes(:cliente, :itens_comandas).where(status: params[:status].singularize)
      @comandas.where('lower(observacao) LIKE ?', "%#{params[:term].downcase}%")
    elsif !params.value?(:status) && params.key?(:term)
      @comandas = Comanda.includes(:forma_pagamento, :cliente).abertas.where('lower(observacao) LIKE ?',
                                                                             "%#{params[:term].downcase}%")
    else
      comandas_status(params[:status])
    end
  end

  def cash_in(comanda, forma)
    cash_in_params = {
      description: "Comandas - #{comanda.cliente.nome_cliente}",
      origin: 'Comandas',
      value: comanda.valor_total,
      method: forma.to_i
    }
    CashIn.create!(cash_in_params)
  end

  def estoque(comanda)
    itens = ItensComanda.where(comanda_id: comanda).select(:produto_id, :quantidade)
    itens.each do |item|
      Produto.saida(item.produto_id, item.quantidade, current_user.id, controller_name)
    end
  end
end
