class ChangeIntegerLimitInClientes < ActiveRecord::Migration[6.0]
  def change
    change_column :clientes, :cpf, :integer, limit: 8
  end
end
