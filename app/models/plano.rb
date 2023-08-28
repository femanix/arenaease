class Plano < ApplicationRecord
  belongs_to :modalidade
  
  validates :descricao, presence: true 
  validates :valor, presence: true 

  monetize :valor_cents
end
