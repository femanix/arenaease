json.extract! invoice, :id, :comanda_id, :nota_chave, :nota_numero, :valor, :created_at, :updated_at
json.url invoice_url(invoice, format: :json)
