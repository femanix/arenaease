class TeamsController < SistemaController
  before_action :set_team, only: %i[show edit update destroy contratar inativar]
  before_action :set_modalidades, only: %i[edit new]
  include TeamsHelper
  # GET /teams or /teams.json
  def index
    @teams = Team.all.includes(:mensalidades, :modalidade, :cliente, :team_account).where(ativo: true)
  end

  # GET /teams/1 or /teams/1.json
  def show; end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit; end

  # POST /teams or /teams.json
  def create
    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        format.html { redirect_to teams_path, flash: { notice: 'Time/Equipe criado com sucesso.', type: 'success' } }
        format.json { render :show, status: :created, location: @team }
      else
        format.html do
          redirect_back fallback_location: teams_path,
                        flash: { notice: 'Houve um erro ao salvar o registro.', type: 'danger' }
        end
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1 or /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to teams_path, flash: { notice: 'Time/Equipe criado com sucesso.', type: 'success' } }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html do
          redirect_back fallback_location: teams_path,
                        flash: { notice: 'Houve um erro ao salvar o registro.',
                                 type: 'danger' }
        end
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1 or /teams/1.json
  def destroy
    @team.destroy
    redirect_to teams_path,
                flash: { notice: 'Cliente foi removido com sucesso.', type: 'success' }
  rescue StandardError => e
    redirect_to teams_path,
                flash: { notice: e.message, type: 'danger' }
  end

  def contratar
    @planos = Plano.where(modalidade_id: @team.modalidade_id)
    return unless request.post?

    @data = params.require(:mensalidade).permit(:plano, :vencimento, :value).merge(team: @team.id)
    if create_mensalidades(@data)
      redirect_to team_account_path(@team), flash: { notice: 'Mensalidades registradas com sucesso.', type: 'success' }
    else
      redirect_to teams_path, flash: { notice: 'Houve um problema ao salvar o registro. ', type: 'danger' }
    end
  end

  def inativar 
    @team.inativar
    redirect_to teams_path, flash: { notice: "O time #{@team.nome} foi inativado.", type: 'danger' }
  end
  

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_team
    @team = Team.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def team_params
    params.require(:team).permit(:nome, :cliente_id, :plano_id, :modalidade_id)
  end

  def set_modalidades
    @modalidades = Modalidade.all
    @clientes = Cliente.all
  end
end
