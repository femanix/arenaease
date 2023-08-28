module MatriculasHelper
  # Cria mensalidades
  def create_mensalidades(matricula)
    month = matricula[:vencimento_matricula].to_date

    12.times do
      Mensalidade.new(
        aluno_id: matricula[:aluno_id],
        vencimento: month,
        value: valor_mensalidade(matricula),
        plano_id: matricula[:plano_id],
        status: 0
      ).save
      month += 1.month
    end
  end

  def valor_mensalidade(matricula)
    valor_plano = Plano.find(matricula[:plano_id]).valor
    if !matricula[:desconto].nil?
      valor_plano - (valor_plano * matricula[:desconto].to_f) / 100
    else
      valor_plano
    end
  end
end
