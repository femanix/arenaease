class RecibosController < ApplicationController

  def show

    @recibo = Recibo.includes(:aluno, :mensalidade).where(token: params[:token]).last
    
  end

  private

  def recibo_params
    params.require(:recibo).permit(:token)
  end
end
