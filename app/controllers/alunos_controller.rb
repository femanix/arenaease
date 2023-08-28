class AlunosController < SistemaController
  before_action :set_aluno, only: %i[show edit update destroy matricular contrato]
  before_action :set_modalidades
  protect_from_forgery with: :null_session

  include AlunosHelper

  # GET /alunos or /alunos.json
  def index
    @alunos = get_alunos(params).page(params[:page]).per(25)
    respond_to do |format|
      format.html
      format.csv { send_data to_csv(get_alunos(params)), filename: "alunos-#{Date.today}.csv" }
    end
  end

  # GET /alunos/1 or /alunos/1.json
  def show; end

  # GET /alunos/new
  def new
    @aluno = Aluno.new
    @modalidades = Modalidade.all
    @aluno.build_endereco
  end

  # GET /alunos/1/edit
  def edit
    @planos = Plano.all
    @mensalidades = Mensalidade.includes(:modalidades).where(aluno_id: @aluno)
  end

  # POST /alunos or /alunos.json
  def create
    @aluno = Aluno.new(remove_mask(aluno_params))

    respond_to do |format|
      if @aluno.save
        format.html do
          redirect_to alunos_list_path(m: params[:location][:modalidade]),
                      flash: { notice: 'Aluno foi criado com sucesso.', type: 'success' }
        end
        format.json { render :show, status: :created, location: @aluno }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @aluno.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /alunos/1 or /alunos/1.json
  def update
    respond_to do |format|
      if @aluno.update(remove_mask(aluno_params))
        format.html do
          redirect_to alunos_list_path(m: params[:location][:modalidade]),
                      flash: { notice: 'Aluno foi atualizado com sucesso.', type: 'success' }
        end
        format.json { render :show, status: :ok, location: @aluno }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @aluno.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alunos/1 or /alunos/1.json
  def destroy
    @aluno.destroy

    respond_to do |format|
      format.html { redirect_to alunos_url, flash: { notice: 'Aluno foi removido.', type: 'success' } }
      format.json { head :no_content }
    end
  end

  def matricular
    @planos = Plano.where(modalidade_id: @aluno.modalidade_id)
    @matricula = Matricula.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def contrato
    render(layout: 'layouts/imprimir_comanda')
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_aluno
    @aluno = Aluno.includes(:modalidade).find(params[:id])
  end

  def set_modalidades
    @modalidades = Modalidade.all
    @planos = Plano.all
  end

  # Only allow a list of trusted parameters through.
  def aluno_params
    params.require(:aluno).permit(:nome, :data_nascimento, :rg, :cpf,
                                  :telefone1, :telefone2, :telefone3, :responsavel1,
                                  :responsavel2, :modalidade_id,
                                  endereco_attributes: %i[id cep rua numero bairro estado cidade])
  end
end
