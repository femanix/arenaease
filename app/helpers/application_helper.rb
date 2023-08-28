module ApplicationHelper
  def search_item(controller = nil, term)
    case controller
    when 'comandas'
      return Comanda.includes( :cliente, :itens_comandas).where("lower(observacao) LIKE ?","%#{term.downcase}%")
    when 'produtos' 
      Produto.where("lower(descricao) LIKE ?","%#{term.downcase}%")
    else
      puts 'else'
    end
    
  end
  
end
