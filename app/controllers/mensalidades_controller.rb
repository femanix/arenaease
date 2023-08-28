class MensalidadesController < SistemaController
  before_action :set_mensalidade, only: %i[edit update destroy pagar estornar]
  include MensalidadesHelper

  def index
    @alunos = get_mensalidades(params).page(params[:page]).per(20)

    respond_to do |format|
      format.html
      format.csv { send_data @mensalidades.to_csv, filename: "mensalidades-#{Date.today}.csv" }
    end
  end

  def show
    @mensalidades = Mensalidade.includes(:aluno, :plano, :recibo).where(aluno_id: params[:id])
    respond_to do |format|
      format.html
      format.csv { send_data to_csv(@mensalidades), filename: "mensalidades-#{Date.today}.csv" }
    end
  end

  def edit; end

  def pagar
    if request.post?
      if @mensalidade.update(mensalidade_params)
        cria_cash_in(@mensalidade, controller_name)
        redirect_to mensalidades_aluno_list_path(id: @mensalidade.aluno.id, m: params[:mensalidade][:modalidade]),
                    flash: { notice: 'Mensalidade paga com sucesso.', type: 'success' }
      end
    else
      respond_to do |format|
        format.html
        format.js
      end
    end
  end

  def update
    if @mensalidade.update(mensalidade_params)
      redirect_back(fallback_location: mensalidades_path,
                    flash: { notice: 'Mensalidade atualizada com sucesso!', type: 'success' })

    else
      redirect_back(fallback_location: mensalidade_path(@mensalidade.aluno_id),
                    flash: { notice: 'Algo deu errado!', type: 'danger' })
    end
  end

  def recibo
    @mensalidade = Mensalidade.includes(:recibo).where(id: params[:id]).last
    emite_recibo(@mensalidade) if @mensalidade.recibo.empty?
    @recibo = Recibo.includes(:aluno, :mensalidade).where(mensalidade_id: params[:id]).last
  end

  def rematricular
    @matricula = Matricula.find(params[:id])
  end

  def cancelar
    @mensalidades = Mensalidade.includes(:aluno, :plano, :recibo).where(aluno_id: params[:id])
    @mensalidades.each(&:cancel)

    respond_to do |format|
      format.html do
        redirect_to mensalidades_list_path(m: params[:m]), flash: { notice: 'Matricula Cancelada', type: 'danger' }
      end
      format.json { head :no_content }
    end
  end

  def estornar
    if @mensalidade.estornar
      redirect_back(fallback_location: mensalidades_path,
                    flash: { notice: 'Mensalidade estornada com sucesso!', type: 'success' })
    else
      redirect_back(fallback_location: mensalidades_path,
                    flash: { notice: 'Houve um erro ao estornar a mensalidade!', type: 'danger' })
    end
  end

  def destroy
    if @mensalidade.saldo == @mensalidade.value
      @mensalidade.destroy

      redirect_back(fallback_location: root_path,
                    flash: { notice: 'Mensalidade removida com sucesso.', type: 'success' })
    else
      redirect_back(fallback_location: root_path,
                    flash: { notice: 'Não é possível excluir uma parcela paga.', type: 'danger' })
    end
  end

  private

  def mensalidade_params
    params.require(:mensalidade).permit(:id, :vencimento, :data_pagamento, :value, :status)
  end

  def set_aluno; end

  def to_csv(mensalidades)
    CSV.generate(headers: true) do |csv|
      csv << %w[ID Nome Status Vencimento Valor]

      mensalidades.each do |mensalidade|
        csv << [mensalidade.id, mensalidade.aluno.nome, mensalidade.status, mensalidade.vencimento, mensalidade.value]
      end
    end
  end

  def set_mensalidade
    @mensalidade = Mensalidade.find(params[:id])
  end
end
