class EstoqueInsController < SistemaController
  before_action :set_estoque_in, only: %i[ show edit update destroy ]
  include EstoqueInsHelper

  # GET /estoque_ins or /estoque_ins.json
  def index
    @estoque_ins = EstoqueIn.includes(:produto, :user, :supplier).all
  end
  
  # GET /estoque_ins/1 or /estoque_ins/1.json
  def show
  end

  # GET /estoque_ins/new
  def new
    @estoque_in = EstoqueIn.new    
    @produto = Produto.all
  end

  # GET /estoque_ins/1/edit
  def edit
    @produto = Produto.all
  end

  # POST /estoque_ins or /estoque_ins.json
  def create
    @produto = Produto.all
    @estoque_in = EstoqueIn.new(estoque_in_params)
     
    
    respond_to do |format|
      if @estoque_in.save
        cria_despesa(@estoque_in) 
        entrada(@estoque_in.produto_id, @estoque_in.quantidade)
        format.html { redirect_to produtos_path, flash: {notice: "Entrada de Estoque realizada.", type: 'success'} }
        format.json { render :show, status: :created, location: @estoque_in }
      else
        format.html {redirect_to produtos_path, flash: {notice: "Um erro impediu que a Entrada de Estoque fosse processada!", type: 'danger'} }
        format.json { render json: @estoque_in.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /estoque_ins/1 or /estoque_ins/1.json
  def update
    respond_to do |format|
      if @estoque_in.update(estoque_in_params)
        format.html { redirect_to estoque_in_url(@estoque_in), flash: {notice: "Entrada de Estoque atualizada.", type: 'success'} }
        format.json { render :show, status: :ok, location: @estoque_in }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @estoque_in.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /estoque_ins/1 or /estoque_ins/1.json
  def destroy
    @estoque_in.destroy

    respond_to do |format|
      format.html { redirect_to estoque_ins_url, flash: {notice: "Entrada de Estoque removida com sucesso.", type: 'success'} }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_estoque_in
      @estoque_in = EstoqueIn.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def estoque_in_params
      params.require(:estoque_in).permit(:produto_id, :quantidade, :preco_compra, :user_id, :supplier_id)
    end

    
end
