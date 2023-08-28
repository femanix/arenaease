class TeamAccountsController < SistemaController
  before_action :set_team_account, only: %i[show update destroy]

  include MensalidadesHelper

  # GET /team_accounts or /team_accounts.json
  def index
    @team_accounts = TeamAccount.all
  end

  # GET /team_accounts/1 or /team_accounts/1.json
  def show
    @mensalidades = Mensalidade.where(team_id: params[:id])
  end

  # GET /team_accounts/new
  def new
    @team_account = TeamAccount.new
  end

  # GET /team_accounts/1/edit
  def edit
    @mensalidade = Mensalidade.find(params[:id])
  end

  # POST /team_accounts or /team_accounts.json
  def create
    @team_account = TeamAccount.new(team_account_params)

    respond_to do |format|
      if @team_account.save
        format.html { redirect_to team_account_url(@team_account), notice: 'Team account was successfully created.' }
        format.json { render :show, status: :created, location: @team_account }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @team_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /team_accounts/1 or /team_accounts/1.json
  def update
    respond_to do |format|
      if @team_account.update(team_account_params)
        format.html { redirect_to team_account_url(@team_account), notice: 'Team account was successfully updated.' }
        format.json { render :show, status: :ok, location: @team_account }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @team_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /team_accounts/1 or /team_accounts/1.json
  def destroy
    @team_account.destroy

    respond_to do |format|
      format.html { redirect_to team_accounts_url, notice: 'Team account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def pagar_aluguel
    @mensalidade = Mensalidade.find(params[:id])
    if request.post?
      begin
        cria_cash_in(@mensalidade, controller_name, mensalidade_params)
        redirect_to team_account_path(@mensalidade.team.id),
                    flash: { notice: 'Mensalidade paga com sucesso.', type: 'success' }
      rescue StandardError => e
        redirect_back fallback_location: root_path,
                      flash: { notice: e.message, type: 'danger' }
      end
    else
      respond_to do |format|
        format.html
        format.js
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_team_account
    @team_account = TeamAccount.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def team_account_params
    params.require(:team_account).permit(:team_id, :balance_cents)
  end

  def mensalidade_params
    params.require(:mensalidade).permit(:id, :vencimento, :data_pagamento, :value, :status, :valor_pago)
  end
end
