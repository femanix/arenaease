json.extract! cliente, :id, :nome_cliente, :telefone, :cpf, :created_at, :updated_at
json.url cliente_url(cliente, format: :json)
