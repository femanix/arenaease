module AlunosHelper
  # Retorna alunos matrículados
  def atrasadas(aluno)
    Aluno.find(aluno.id).mensalidades_atrasadas
  end

  # Gera CSV do model Alunos
  def to_csv(aluno)
    CSV.generate(headers: true) do |csv|
      csv << ['ID', 'Nome', 'Data de Nascimento', 'Telefone', 'Responsavel', 'Plano', 'Modalidade']

      aluno.each do |aluno|
        csv << [
          aluno.id,
          aluno.nome,
          aluno.data_nascimento,
          aluno.telefone1,
          aluno.responsavel1,
          aluno.plano,
          aluno.modalidade.descricao
        ]
      end
    end
  end

  # Remove a mascara de telefone de um obj do tipo parâmetro
  def remove_mask(aluno)
    aluno[:telefone1] = aluno[:telefone1].gsub(/\D/, '')
    aluno[:telefone2] = aluno[:telefone2].gsub(/\D/, '')
    aluno[:telefone3] = aluno[:telefone3].gsub(/\D/, '')
    aluno[:cpf] = aluno[:cpf].gsub(/\D/, '')
    aluno
  end

  # Metódo para pesquisar alunos
  def get_alunos(params)
    case [params[:m], params.key?(:term)]
    when ['chute_inicial', true]
      Aluno.matriculados.where(modalidade_id: 4)
           .where(search_condition(params))
    when ['chute_inicial', false]
      Aluno.where(modalidade_id: 4).left_outer_joins(:matricula).select('DISTINCT alunos.*')
    when ['beach_volley', true]
      Aluno.matriculados.where(modalidade_id: 2)
           .where(search_condition(params))
    when ['beach_volley', false]
      Aluno.where(modalidade_id: 2).left_outer_joins(:matricula).select('DISTINCT alunos.*')
    when ['futvolei', true]
      Aluno.matriculados.where(modalidade_id: 5)
           .where(search_condition(params))
    when ['futvolei', false]
      Aluno.where(modalidade_id: 5).left_outer_joins(:matricula).select('DISTINCT alunos.*')
    end
  end

  private

  # metodo responsável por gerar o termo de pesquisa SQL
  def search_condition(params)
    ['lower(nome) LIKE :term OR matriculas.id LIKE :term', { term: "%#{params[:term].downcase}%" }]
  end
end
