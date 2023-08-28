class EstoqueIn < ApplicationRecord
  belongs_to :produto
  belongs_to :user
  belongs_to :supplier

  validates :produto, presence: true
  validates :preco_compra, presence: true

  monetize :preco_compra_cents
end
