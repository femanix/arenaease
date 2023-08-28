class EmiteNf
  include InvoicesHelper
  def conn
    conn = Faraday.new(
      url: 'https://staging.api.notafacil.io/v1/',
      headers: {
        'Authorization' => 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9zdGFnaW5nLmFwaS5ub3RhZmFjaWwuaW9cL3YxXC9hdXRoXC9sb2dpbiIsImlhdCI6MTY4MTMyNzkyNCwiZXhwIjoxNzcxMzI3OTI0LCJuYmYiOjE2ODEzMjc5MjQsImp0aSI6Ik1GaFBZd0VYU1lIekZvaXciLCJzdWIiOjE0NCwicHJ2IjoiNjc1ZmFlZTM4MzViZjUxNDNmMTJjOGFlMWFhMWQxZDI3NTBhYmQ1MSIsInV1aWQiOiI0YTVlZGMwNC0yZmZkLTQyZjMtYTNmNi0xODc3NDgyNDk4MzgiLCJpZHVzZXIiOjE0NCwiaWRfZW1wcmVzYSI6NjYxLCJpZF9lbXByZXNhX3BhaSI6bnVsbH0.stnWgvSrRmZALL0hqLWUxj5w3k1wHiaxKKr2XpzuIJs',
        'Content-Type' => 'application/json',
        'accept' => 'application/json',
        'consumer-id' => 'roJErmQwEYYCDsqBPJs1cA==',
        'secret-key' => 'wXnzeaZ5UAcx'
      }
    )
  end

  def emite_nota(comanda)
    response = conn.post('nf/salvar') do |req|
      req.body = {
        "calcular": true,
        "emitir": true,
        "natureza_operacao": 'Vendas externa',
        "modelo": 65,
        "serie": 1,
        "numeracao": 1,
        "data_emissao": Time.now.strftime('%Y-%m-%d %H:%M:%S'),
        "data_entrada_saida": Time.now.strftime('%Y-%m-%d %H:%M:%S'),
        "tipo": 1,
        "codigo_ibge": '3552502',
        "tipo_impressao": 4,
        "tipo_emissao": 1,
        "ambiente": 2,
        "finalidade": 1,
        "operacao_consumidor_final": 1,
        "tipo_atendimento": 1,
        "processo_emissao": 1,
        "transporte": {
          "modalidade_frete": 9
        },
        "parcelas_pagamento": [
          {
            "a_vista": 0,
            "metodo": '01',
            "valor": comanda.valor_total_cents
          }
        ],
        "produtos": produtos_nf(comanda)
      }.to_json
    end
    return unless response.status == 201

    data = JSON.parse(response.body)
    puts data
    Invoice.new(comanda:, nota_chave: data['data']['nota_chave'], nota_numero: data['data']['numeracao'],
                valor_cents: comanda.valor_total_cents, nota_status: data['data']['nota_status'], nota_situacao: data['data']['nota_situacao']).save!
  end

  def lista_empresas; end
end
