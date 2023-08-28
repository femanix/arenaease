json.extract! cash_out, :id, :description, :category, :value, :method, :expiration, :payment_date, :supplier, :created_at, :updated_at
json.url cash_out_url(cash_out, format: :json)
