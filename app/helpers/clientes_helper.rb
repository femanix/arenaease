module ClientesHelper

  def remove_mask(cliente)
    cliente[:cpf] = cliente[:cpf].gsub(/\D/, '')
    cliente[:telefone] = cliente[:telefone].gsub(/\D/, '')

    cliente
  end
end
