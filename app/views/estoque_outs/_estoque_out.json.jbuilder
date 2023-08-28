json.extract! estoque_out, :id, :produto_id, :quantidade, :admin_id, :created_at, :updated_at
json.url estoque_out_url(estoque_out, format: :json)
