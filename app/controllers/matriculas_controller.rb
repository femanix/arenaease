class MatriculasController < SistemaController
  include MatriculasHelper
  before_action :matricula_params
  before_action :set_matricula, only: %i[edit update]

  def create
    @matricula = Matricula.new(matricula_params.except(:vencimento_matricula))
    respond_to do |format|
      if @matricula.save
        create_mensalidades(matricula_params)
        format.html do
          redirect_to mensalidades_aluno_list_path(id: @matricula.aluno.id, m: params[:location][:modalidade]),
                      flash: { notice: 'Aluno foi matriculado com sucesso.', type: 'success' }
        end
      else
        format.html do
          redirect_to alunos_path, flash: { notice: 'Houve um erro ao cadastrar o aluno.', type: 'danger' }
        end
      end
    end
  end

  def edit; end

  def update
    flash = if @matricula.update(matricula_params.except(:vencimento_matricula))
              create_mensalidades(matricula_params)
              { notice: 'Matrícula foi atualizada com sucesso.', type: 'success' }
            else
              { notice: 'Houve um erro ao processar a matrícula.', type: 'danger' }
            end
    redirect_back(fallback_location: root_path, flash:)
  end

  private

  def set_matricula
    @matricula = Matricula.find(params[:id])
  end

  def matricula_params
    params.require(:matricula).permit(:id, :data_matricula, :vencimento_matricula, :validade_exame, :renovacao, :plano_id, :aluno_id, :status, :desconto,
                                      class_schedule: [])
  end
end
