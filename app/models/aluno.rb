class Aluno < ApplicationRecord
  has_one :matricula
  has_one :endereco
  belongs_to :modalidade
  has_many :mensalidades

  validates :nome, presence: true
  validates :data_nascimento, presence: true
  validates :cpf, presence: true
  validates :telefone1, presence: true

  accepts_nested_attributes_for :endereco

  def matriculado?
    Matricula.where(aluno_id: id).exists?
  end

  def plano
    if matriculado?
      matricula.plano.descricao
    else
      'Aluno não matriculado.'
    end
  end

  def self.matriculados
    joins(:matricula).distinct
  end

  def mensalidades_atrasadas
    Mensalidade.where(aluno_id: id, status: 'Em atraso')
  end

  def self.to_csv
    attributes = %w[id nome data_nascimento mensalidades_atrasadas valor_em_atraso]

    CSV.generate(headers: true) do |csv|
      csv << attributes
      matriculados.each do |aluno|
        csv << [
          aluno.id, aluno.nome, aluno.data_nascimento,
          aluno.mensalidades_atrasadas.size,
          aluno.mensalidades_atrasadas.map(&:value).sum
        ]
      end
    end
  end

  def self.ransackable_attributes(_auth_object = nil)
    # %w[nome modalidade]
    %w[nome modalidade_id descricao]
  end
end
