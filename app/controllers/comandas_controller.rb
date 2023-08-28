class ComandasController < SistemaController
  before_action :set_comanda, only: %i[show edit update destroy encerrar pagar imprimir emitir_nf]
  before_action :set_itens, only: %i[show pagar imprimir]
  before_action :sistema_params, only: %i[new edit create pagar index]
  authorize_resource :comanda
  include ComandasHelper

  def index
    @comandas = search_comanda(params).page(params[:page]).per(6)
  end

  # GET /comandas/1 or /comandas/1.json
  def show
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /comandas/new
  def new
    @comanda = Comanda.new
    if params[:balcao]
      @comanda.cliente_id = 1
      @methods = CashIn.methods
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /comandas/1/edit
  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /comandas or /comandas.json
  def create
    @comanda = Comanda.new(comanda_params)
    respond_to do |format|
      if @comanda.save
        format.html { redirect_to comandas_path, notice: "Inserida nova comanda para #{@comanda.cliente.nome_cliente}" }
        format.json { render :show, status: :created, location: @comanda }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comanda.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comandas/1 or /comandas/1.json
  def update
    respond_to do |format|
      if @comanda.update(comanda_params)
        format.html do
          redirect_to comandas_path, notice: "Comanda atualizada com sucesso Cliente: #{@comanda.cliente.nome_cliente}"
        end
        format.json { render :show, status: :ok, location: @comanda }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comanda.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comandas/1 or /comandas/1.json
  def destroy
    @comanda.destroy

    respond_to do |format|
      format.html { redirect_to comandas_url, flash: { notice: 'Comanda foi removida com sucesso.', type: 'success' } }
      format.json { head :no_content }
    end
  end

  def balcao
    @comanda = Comanda.new(comanda_params)
    return unless @comanda.save

    @comanda.encerrar(params[:data][:method])
    estoque(@comanda)
    redirect_to comandas_url, flash: { notice: 'Venda encerrada com sucesso.', type: 'success' }
  end

  def encerrar
    if @comanda.encerrada?
      redirect_to comandas_path, flash: { notice: 'Comanda já encerrada', type: 'danger' }
    else
      @comanda.encerrar(params[:forma])
      estoque(@comanda) # Decidir se irá se tornar um helper ou um metodo de classe
      respond_to do |format|
        format.html do
          redirect_to comandas_path,
                      flash: { notice: "Comanda encerrada: #{@comanda.cliente.nome_cliente}", type: 'success' }
        end
      end
    end
  end

  def pagar
    @comanda = Comanda.includes(:cliente, :itens_comandas).find(params[:id])
  end

  def imprimir
    render(layout: 'layouts/imprimir_comanda')
  end

  def emitir_nf
    ExampleJob.perform_later(@comanda)
    redirect_to comandas_path, flash: { notice: 'Nota Fiscal Enviada', type: 'danger' }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comanda
    @comanda = Comanda.find(params[:id])
  end

  def set_itens
    @itens = ItensComanda.where(comanda_id: params[:id])
  end

  # Only allow a list of trusted parameters through.
  def comanda_params
    params.require(:comanda).permit(:itens_comanda, :cliente_id, :observacao, :forma_pagamento_id, :valor_total, :status,
                                    itens_comandas_attributes: %i[id comanda produto_id quantidade valor _destroy])
  end

  def sistema_params
    @clientes = Cliente.all
    @formas_pagamento = FormaPagamento.all
    @produtos = Produto.all
  end
end
