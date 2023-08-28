json.extract! produto, :id, :descricao, :valor, :ncm, :quantidade_minima, :created_at, :updated_at
json.url produto_url(produto, format: :json)
