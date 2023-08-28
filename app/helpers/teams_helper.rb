module TeamsHelper
  # Cria mensalidades
  def create_mensalidades(data)
    month = data[:vencimento].to_date
    plano = Plano.find(data[:plano]).valor
    puts data
    12.times do
      Mensalidade.new(
        team_id: data[:team],
        vencimento: month,
        value: plano,
        plano_id: data[:plano],
        status: 0
      ).save
      month += 1.month
    end
  end

  def balance_class(team)
    return if team.team_account.balance.zero?

    team.team_account.balance.negative? ? 'danger' : 'success'
  end

  def mensalidades?(team)
    if team.mensalidades.present?
      ' hidden'
    else
      'success'
    end
  end
end
