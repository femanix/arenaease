class CreateItensComandas < ActiveRecord::Migration[5.2]
  def change
    create_table :itens_comandas do |t|
      t.references :comanda, foreign_key: true
      t.references :produto, foreign_key: true
      t.integer :quantidade
      t.integer :valor_cents, default: 0, null: false

      t.timestamps
    end
  end
end
