class ProdutosController < SistemaController
  before_action :set_produto, only: %i[show edit update destroy]
  before_action :suppliers
  include ProdutosHelper

  # GET /produtos or /produtos.json
  def index
    @produtos = Produto.all.page(params[:page]).per(7)
    respond_to  do |format|
      format.html
      format.csv { send_data to_csv(@produtos), filename: "produtos-#{Date.today}.csv" }
    end
  end

  # GET /produtos/1 or /produtos/1.json
  def show; end

  # GET /produtos/new
  def new
    @produto = Produto.new
    @produto.build_tributo
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /produtos/1/edit
  def edit; end

  # POST /produtos or /produtos.json
  def create
    @produto = Produto.new(produto_params)
    respond_to do |format|
      if @produto.save
        format.html { redirect_to produtos_path, flash: { notice: 'Produto foi criado com sucesso!', type: 'success' } }
        format.json { render :show, status: :created, location: @produto }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @produto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /produtos/1 or /produtos/1.json
  def update
    respond_to do |format|
      if @produto.update(produto_params)
        format.html do
          redirect_to produtos_url, flash: { notice: 'Produto foi atualizado com sucesso.', type: 'success' }
        end
        format.json { render :show, status: :ok, location: @produto }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @produto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /produtos/1 or /produtos/1.json
  def destroy
    @produto.destroy

    respond_to do |format|
      format.html { redirect_to produtos_url, flash: { notice: 'Produto foi removido com sucesso!', type: 'success' } }
      format.json { head :no_content }
    end
  end

  def search
    if !params.key?(:term) || params[:term].empty?
      redirect_to produtos_path
    else
      @produtos = search_item(controller_name, params[:term])
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_produto
    @produto = Produto.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def produto_params
    params.require(:produto).permit(:descricao, :categoria, :preco_compra, :preco_venda, :ncm, :itens_cx,
                                    :quantidade_minima, :data_validade, :supplier_id, :unidade,
                                    tributo_attributes: %i[id origem ncm cest cst cfop pis_cst confis_cst _destroy])
  end

  def suppliers
    @suppliers = Supplier.all
  end
end
