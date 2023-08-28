json.extract! estoque_in, :id, :produto_id, :quantidade, :valor, :admin_id, :fornecedor_id, :created_at, :updated_at
json.url estoque_in_url(estoque_in, format: :json)
