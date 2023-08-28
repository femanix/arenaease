class CashIn < ApplicationRecord
  acts_as_paranoid
 
  belongs_to :mensalidade, optional: true

  before_create :set_params
  enum method: ['Dinheiro', 'Pix', 'Cartão de Crédito', 'Cartão de Débito']

  monetize :value_cents

  def set_params
    return unless date.nil?

    self.date = Date.today
  end

  def self.total
    sum(:value_cents)
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at date description origin mensalidade_id]
  end

  ransacker :date, type: :date do
    Arel.sql('date(date)')
  end
end
