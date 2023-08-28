module CashOutsHelper
  def get_cashOuts(params)
    if !params.key?(:start_date)
      CashOut.all
    else
      CashOut.where(created_at: params[:start_date].to_date.beginning_of_day..params[:end_date].to_date.end_of_day)
    end
  end

  def to_csv(cashouts)
    CSV.generate(headers: true) do |csv|
      csv << ['Data', 'ID', 'Descricao', 'Categoria', 'Valor', 'Forma de Pagamento', 'Vencimento', 'Data de Pagamento']

      cashouts.each do |cashout|
        csv << [
          cashout.created_at.to_date,
          cashout.id,
          cashout.description,
          cashout.category,
          cashout.value,
          cashout.method,
          cashout.expiration,
          cashout.payment_date
        ]
      end
    end
  end

  def nova_despesa(cashout)
    expiration = cashout[:expiration].to_date

    qtd = if cashout[:qtd].empty?
            1
          else
            cashout[:qtd].to_i
          end

    duration = case cashout[:frequency]
               when 'Anual' then 1.year
               when 'Mensal'then 1.month
               when 'Quinzenal'then 15.days
               else 0.days
               end

    qtd.to_i.times do
      create_cashout(cashout, expiration)
      expiration += duration
    end
  end

  def create_cashout(cashout, expiration)
    CashOut.create!(
      description: cashout[:description],
      category: cashout[:category],
      value: cashout[:value],
      method: cashout[:method],
      expiration:,
      payment_date: cashout[:payment_date],
      supplier: cashout[:supplier]
    )
  end

  def getCategories
    CashOut.select(:category).distinct
  end
end
