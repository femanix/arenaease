class CashInsController < SistemaController
  before_action :set_cash_in, only: %i[show edit update destroy]
  include CashInsHelper
  # GET /cash_ins or /cash_ins.json
  def index
    @q = CashIn.ransack(params[:q])
    @cash_ins = @q.result(distinct: true).order(date: :desc).page(params[:page]).per(20)
    respond_to  do |format|
      format.html
      format.csv { send_data to_csv(@q.result), filename: "receitas-#{Date.today}.csv" }
      format.json { render json: @cash_ins }
    end
  end

  # GET /cash_ins/1 or /cash_ins/1.json
  def show; end

  # GET /cash_ins/new
  def new
    @cash_in = CashIn.new
  end

  # GET /cash_ins/1/edit
  def edit; end

  # POST /cash_ins or /cash_ins.json
  def create
    @cash_in = CashIn.new(cash_in_params)
    respond_to do |format|
      if @cash_in.save
        format.html { redirect_to cash_ins_path, flash: { notice: 'Entrada registrada com sucesso.', type: 'success' } }
        format.json { render :show, status: :created, location: @cash_in }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cash_in.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cash_ins/1 or /cash_ins/1.json
  def update
    respond_to do |format|
      if @cash_in.update(cash_in_params)
        format.html { redirect_to cash_ins_path, flash: { notice: 'Entrada atualizada com sucesso.', type: 'success' } }
        format.json { render :show, status: :ok, location: @cash_in }
      else
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @cash_in.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cash_ins/1 or /cash_ins/1.json
  def destroy
    if @cash_in.mensalidade.present?
      respond_to do |format|
        format.html do
          redirect_back(fallback_location: cash_ins_url,
                        flash: { notice: 'Não é possível excluir uma receita associada a uma mensalidade.',
                                 type: 'danger' })
        end
        format.json { head :no_content }
      end
    else
      if @cash_in.destroy
        respond_to do |format|
          format.html { redirect_to cash_ins_url, flash: { notice: 'Entrada removida com sucesso.', type: 'success' } }
          format.json { head :no_content }
        end
      else
        respond_to do |format|
          format.html { redirect_to cash_ins_url, flash: { notice: 'Houve um problema ao processar!', type: 'success' } }
          format.json { head :bad_request }
        end
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_cash_in
    @cash_in = CashIn.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def cash_in_params
    params.require(:cash_in).permit(:description, :origin, :value, :method)
  end
end
