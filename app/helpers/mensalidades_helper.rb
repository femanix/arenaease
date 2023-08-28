module MensalidadesHelper
  include AlunosHelper

  def nome_aluno
    Aluno.find(params[:id]).nome
  end

  def cria_cash_in(obj, controller, params = nil)
    case controller
    when 'mensalidades'
      obj.update(valor_pago: obj.value)
      CashIn.create!(
        description: obj.aluno.nome.titleize,
        origin: "#{obj.aluno.modalidade.descricao} - Mensalidades",
        value: obj.value,
        method: 'Dinheiro',
        date: obj.data_pagamento,
        mensalidade_id: obj.id
      ).save
    when 'team_accounts'
      valor_pago = Money.new(params[:valor_pago].gsub(/[.,]/, ''))
      raise 'Valor pago não pode ser maior que o saldo da mensalidade' if obj.saldo < valor_pago

      atualiza_mensalidade(obj, valor_pago, params[:data_pagamento])
      CashIn.create!(
        description: obj.team.nome.titleize,
        origin: "#{obj.team.modalidade.descricao} - Mensalidades",
        value: valor_pago,
        method: 'Dinheiro',
        date: params[:data_pagamento],
        mensalidade_id: obj.id
      ).save

    end
  end

  def whatsapp_recibo(mensalidade)
    link_recibo = "https://app.urupaarena.com.br/recibo/#{mensalidade.recibo.last.token}"
    text = "Olá, tudo bem? Obrigado por pagar sua mensalidade.%0aVocê pode acessar o recibo correspondente no link abaixo.%0a[#{link_recibo}]%0aFique à vontade para entrar em contato conosco se tiver alguma dúvida."
    texto_formatado = text.gsub("\n", '%0a')
    "https://api.whatsapp.com/send?phone=+55#{mensalidade.aluno.telefone1}&text=#{texto_formatado}"
  end

  def emite_recibo(mensalidade)
    Recibo.create!(
      aluno_id: mensalidade.aluno.id,
      cpf: mensalidade.aluno.cpf,
      valor: mensalidade.value,
      mensalidade_id: mensalidade.id,
      token: SecureRandom.urlsafe_base64
    )
  end

  def numero_recibo(recibo)
    format('%d/%d', recibo.created_at.year, recibo.id)
  end

  def valor_por_extenso(valor)
    # Converte o valor para uma string por extenso
    valor_extenso = valor.to_i.to_words

    # Adiciona a palavra "reais" à string por extenso
    valor_extenso += ' reais'

    # Adiciona a parte decimal à string por extenso, se necessário
    if valor.to_s.include?('.')
      parte_decimal = valor.to_s.split('.').last.to_i
      centavos = parte_decimal.to_words
      valor_extenso += " e #{centavos} centavos"
    end
    # Retorna a string por extenso
    valor_extenso
  end

  def atualiza_mensalidade(obj, valor_pago, data_pagamento = Date.today)
    data_pagamento.present? ? data_pagamento : data_pagamento = Date.today

    obj.update(valor_pago: obj.valor_pago + valor_pago, data_pagamento:)
    obj.atualiza_parcela_paga
  end
end

def get_mensalidades(params)
  case [params[:m], params.key?(:term)]
  when ['beach_volley', true]
    Aluno.matriculados.where(modalidade_id: 2)
         .where(search_condition(params))
  when ['futvolei', true]
    Aluno.matriculados.where(modalidade_id: 5)
         .where(search_condition(params))
  when ['chute_inicial', true]
    Aluno.matriculados.where(modalidade_id: 4)
         .where(search_condition(params))
  when ['beach_volley', false]
    Aluno.includes(:mensalidades, :matricula, :modalidade).matriculados.where(modalidade_id: 2)
  when ['futvolei', false]
    Aluno.includes(:mensalidades, :matricula, :modalidade).matriculados.where(modalidade_id: 5)
  when ['chute_inicial', false]
    Aluno.includes(:mensalidades, :matricula, :modalidade).matriculados.where(modalidade_id: 4)
  end
end

# metodo responsável por gerar o termo de pesquisa SQL
def search_condition(params)
  ['lower(nome) LIKE :term OR matriculas.id LIKE :term', { term: "%#{params[:term].downcase}%" }]
end
