class InicioController < SistemaController
  before_action :authenticate_admin!
  def index
  end
end
