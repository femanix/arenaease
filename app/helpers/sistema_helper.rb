module SistemaHelper
  def to_money(valor)
    Money.new(valor).format
  end

  def date_format(date)
    date.present? ? date.strftime('%d/%m/%Y') : ''
  end

  def phone_format(phone)
    return unless phone.present?
    return if phone.to_i < 1

    p = phone.to_s
    "(#{p[0..1]}) #{p[2..5]}-#{p[6..9]}"
  end

  def cpf_format(cpf)
    CPF.new(cpf).formatted
  end
end
