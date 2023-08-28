class PlanosController < SistemaController
  before_action :set_plano, only: %i[ edit update ]
  before_action :plano_params, only: %i[ create ]
  before_action :set_modalidades, only: %i[ index edit new ]

  def index
    @planos = Plano.includes(:modalidade).all
  end
  
  def create
    @plano = Plano.new(plano_params)

    respond_to do |format|
      if @plano.save
        format.html { redirect_to request.original_url, flash: {notice: "Plano foi criado com sucesso.", type: 'success'} }
      else
        format.html { redirect_to request.original_url, flash: {notice: "Houve um erro ao criar o plano.", type: 'danger'} }
      end
    end
  end

  def update
    respond_to do |format|
      if @plano.update(plano_params)
        format.html { redirect_to planos_path, flash: {notice: "Plano foi atualizado com sucesso.", type: 'success'} }
      else
        format.html { redirect_to planos_path, flash: {notice: "Houve um problema ao salvar o plano.", type: 'danger'}}
      end
    end
  end

  def new
    @plano = Plano.new
  end

  def edit
  end

  private

  def set_plano
    @plano = Plano.find(params[:id])
  end

  def set_modalidades
    @modalidades = Modalidade.all
  end
  

  def plano_params
    params.require(:plano).permit(:descricao, :modalidade_id, :valor)
  end
  
end
