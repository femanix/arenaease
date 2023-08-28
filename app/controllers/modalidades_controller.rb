class ModalidadesController < SistemaController
  before_action :modalidade_params, only: %i[ create ]
  protect_from_forgery with: :null_session

  def index
    @modalidades = Modalidade.all
  end
  
  def create
    @modalidade = Modalidade.new(modalidade_params)

    respond_to do |format|
      if @modalidade.save
        format.html { redirect_to request.original_url, flash: {notice: "Modalidade foi criada com sucesso.", type: 'success'} }
        format.json { render :show, status: :created, location: @modalidade }
      else
        format.html { redirect_to request.original_url, flash: {notice: "Houve um erro ao criar a modalidade.", type: 'danger'} }
        format.json { render json: @modalidade.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @modalidade = Modalidade.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def modalidade_params
    params.require(:modalidade).permit(:descricao)
  end
end