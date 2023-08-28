class EstoqueOutsController < SistemaController
  before_action :set_estoque_out, only: %i[show edit update destroy]

  # GET /estoque_outs or /estoque_outs.json
  def index
    @estoque_outs = EstoqueOut.includes(:produto, :user).all
  end

  # GET /estoque_outs/1 or /estoque_outs/1.json
  def show; end

  # GET /estoque_outs/new
  def new
    @estoque_out = EstoqueOut.new
    @produto = Produto.all
  end

  # GET /estoque_outs/1/edit
  def edit; end

  # POST /estoque_outs or /estoque_outs.json
  def create
    @produto = Produto.all
    @estoque_out = EstoqueOut.new(estoque_out_params)
    respond_to do |format|
      if @estoque_out.save!
        Produto.saida(@estoque_out.produto_id, @estoque_out.quantidade, current_user.id, controller_name)
        format.html { redirect_to produtos_path, flash: {notice: 'Saída de Estoque removida com sucesso.', type: 'success'} }
        format.json { render :show, status: :created, location: @estoque_out }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @estoque_out.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /estoque_outs/1 or /estoque_outs/1.json
  def update
    respond_to do |format|
      if @estoque_out.update(estoque_out_params)
        format.html { redirect_to estoque_out_url(@estoque_out), notice: 'Saída de Estoque atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @estoque_out }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @estoque_out.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /estoque_outs/1 or /estoque_outs/1.json
  def destroy
    @estoque_out.destroy

    respond_to do |format|
      format.html { redirect_to estoque_outs_url, flash: {notice: 'Saída de Estoque removida com sucesso.', type: 'success'} }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_estoque_out
    @estoque_out = EstoqueOut.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def estoque_out_params
    params.require(:estoque_out).permit(:produto_id, :quantidade, :user_id, :origem)
  end

  def saida(produto, quantidade)
    p = Produto.find(produto)
    if p.quantidade > quantidade
      saida = p.quantidade - quantidade
      p.quantidade = saida
      p.save!
    end
  end
end
