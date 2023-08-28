class Matricula < ApplicationRecord
  belongs_to :plano
  belongs_to :aluno

  validates :aluno_id, uniqueness: true
  validates :data_matricula, presence: true

  enum status: %w[Ativa Inativa]

  def class_schedule=(values)
    self[:class_schedule] = values.join(',')
  end

  def class_schedule
    self[:class_schedule].split(',')
  end
end
