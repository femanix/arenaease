class ItensComandasController < SistemaController
  before_action :set_itens_comanda, only: %i[ show edit update destroy ]

  # GET /itens_comandas or /itens_comandas.json
  def index
    @itens_comandas = ItensComanda.includes(:comanda, :produto).all
  end

  # GET /itens_comandas/1 or /itens_comandas/1.json
  def show
  end

  # GET /itens_comandas/new
  def new
    @itens_comanda = ItensComanda.new
  end

  # GET /itens_comandas/1/edit
  def edit
  end

  # POST /itens_comandas or /itens_comandas.json
  def create
    @itens_comanda = ItensComanda.new(itens_comanda_params)

    respond_to do |format|
      if @itens_comanda.save
        format.html { redirect_to itens_comanda_url(@itens_comanda), notice: "Itens comanda was successfully created." }
        format.json { render :show, status: :created, location: @itens_comanda }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @itens_comanda.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /itens_comandas/1 or /itens_comandas/1.json
  def update
    respond_to do |format|
      if @itens_comanda.update(itens_comanda_params)
        format.html { redirect_to itens_comanda_url(@itens_comanda), notice: "Itens comanda was successfully updated." }
        format.json { render :show, status: :ok, location: @itens_comanda }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @itens_comanda.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /itens_comandas/1 or /itens_comandas/1.json
  def destroy
    @itens_comanda.destroy

    respond_to do |format|
      format.html { redirect_to itens_comandas_url, notice: "Itens comanda was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_itens_comanda
      @itens_comanda = ItensComanda.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def itens_comanda_params
      params.require(:itens_comanda).permit(:comanda_id, :produto_id, :quantidade, :valor)
    end
end
