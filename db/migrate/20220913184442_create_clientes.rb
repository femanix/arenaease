class CreateClientes < ActiveRecord::Migration[5.2]
  def change
    create_table :clientes do |t|
      t.text :nome_cliente
      t.text :telefone
      t.integer :cpf, limit: 8

      t.timestamps
    end
  end
end
