class Invoice < ApplicationRecord
  belongs_to :comanda, inverse_of: :invoice

  monetize :valor_cents
end
