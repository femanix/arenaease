class CashOutsController < SistemaController
  before_action :set_cash_out, only: %i[show edit update destroy]
  before_action :suppliers, only: %i[edit index new]
  include CashOutsHelper

  # GET /cash_outs or /cash_outs.json
  def index
    @q = CashOut.ransack(params[:q])
    @cash_outs = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(7)
    respond_to do |format|
      format.html
      format.csv { send_data to_csv(@cash_outs), filename: "despesas-#{Date.today}.csv" }
    end
  end

  # GET /cash_outs/1 or /cash_outs/1.json
  def show; end

  # GET /cash_outs/new
  def new
    @cash_out = CashOut.new
  end

  # GET /cash_outs/1/edit
  def edit; end

  # POST /cash_outs or /cash_outs.json
  def create
    respond_to do |format|
      if nova_despesa(cash_out_params)
        format.html { redirect_to cash_outs_url, flash: { notice: 'Despesa criada com sucesso.', type: 'success' } }
        format.json { render :show, status: :created, location: @cash_out }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cash_out.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cash_outs/1 or /cash_outs/1.json
  def update
    respond_to do |format|
      if @cash_out.update(cash_out_params.except(:qtd, :frequency))
        format.html { redirect_to cash_outs_url, flash: { notice: 'Despesa atualizada com sucesso.', type: 'success' } }
        format.json { render :show, status: :ok, location: @cash_out }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cash_out.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cash_outs/1 or /cash_outs/1.json
  def destroy
    @cash_out.destroy

    respond_to do |format|
      format.html { redirect_to cash_outs_url, flash: { notice: 'Despesa foi excluída.', type: 'success' } }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_cash_out
    @cash_out = CashOut.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def cash_out_params
    params.require(:cash_out).permit(:description, :category, :value, :method, :expiration, :payment_date, :supplier,
                                     :frequency, :qtd)
  end

  def suppliers
    @suppliers = Supplier.all
  end
end
