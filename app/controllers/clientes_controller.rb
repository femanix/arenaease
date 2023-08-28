class ClientesController < SistemaController
  before_action :set_cliente, only: %i[show edit update destroy]
  include ClientesHelper

  # GET /clientes or /clientes.json
  def index
    @clientes = Cliente.all.page(params[:page]).per(10)
  end

  # GET /clientes/1 or /clientes/1.json
  def show
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /clientes/new
  def new
    @cliente = Cliente.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /clientes/1/edit
  def edit; end

  # POST /clientes or /clientes.json
  def create
    @cliente = Cliente.new(cliente_params)
    @cliente.cpf = CPF.new(cliente_params[:cpf]).stripped
    respond_to do |format|
      if @cliente.save
        format.html { redirect_to clientes_path, flash: { notice: 'Cliente criado com sucesso.', type: 'success' } }
        format.json { render :show, status: :created, location: @cliente }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clientes/1 or /clientes/1.json
  def update
    respond_to do |format|
      if @cliente.update(remove_mask(cliente_params))
        format.html { redirect_to clientes_path, flash: { notice: 'Cliente atualizado com sucesso.', type: 'success' } }
        format.json { render :show, status: :ok, location: @cliente }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clientes/1 or /clientes/1.json
  def destroy
    @cliente.destroy

    respond_to do |format|
      format.html { redirect_to clientes_url, flash: { notice: 'Cliente foi removido com sucesso.', type: 'success' } }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_cliente
    @cliente = Cliente.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def cliente_params
    params.require(:cliente).permit(:nome_cliente, :telefone, :cpf)
  end
end
