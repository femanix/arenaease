class Recibo < ApplicationRecord
  belongs_to :aluno
  belongs_to :mensalidade
  monetize :valor_cents

  def numero
    [self.created_at.year, self.id].join('/')
  end  
end
