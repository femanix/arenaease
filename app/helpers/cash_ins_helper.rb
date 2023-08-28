module CashInsHelper
  def get_cashIns(params)
    if !params.has_key?(:search)
      CashIn.all
    else
      CashIn.where('lower(origin) LIKE ?', "%#{params[:origin].to_s.downcase}%")
            .where(created_at: params[:start_date].to_date.beginning_of_day..params[:end_date].to_date.end_of_day)
    end
  end

  def to_csv(cashins)
    CSV.generate(headers: true) do |csv|
      csv << ['Data', 'ID', 'Descricao', 'Origem', 'Valor', 'Forma de Pagamento']

      cashins.each do |cashin|
        csv << [
          cashin.date,
          cashin.id,
          cashin.description,
          cashin.origin,
          cashin.value,
          cashin.method
        ]
      end
    end
  end

  def getOrigins
    CashIn.select(:origin).distinct
  end
end
