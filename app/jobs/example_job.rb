class ExampleJob < ApplicationJob
  queue_as :emissao_nf

  def perform(comanda)
    unless comanda.invoice.present?
      response = EmiteNf.new
      response.emite_nota(comanda)
    end
  end
end
