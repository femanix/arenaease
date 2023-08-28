class CashOut < ApplicationRecord
  acts_as_paranoid
  attribute :expiration, :date, default: Date.today

  monetize :value_cents

  def paga?
    !payment_date.nil?
  end

  def self.total
    sum(:value_cents)
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at date description category]
  end

  ransacker :created_at, type: :date do
    Arel.sql('date(created_at)')
  end
end
