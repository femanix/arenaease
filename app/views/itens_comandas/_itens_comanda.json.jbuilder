json.extract! itens_comanda, :id, :comanda_id, :produto_id, :quantidade, :valor, :created_at, :updated_at
json.url itens_comanda_url(itens_comanda, format: :json)
