class CreateProdutos < ActiveRecord::Migration[5.2]
  def change
    create_table :produtos do |t|
      t.string :descricao
      t.integer :preco_compra_cents, default: 0, null: false
      t.integer :preco_venda_cents, default: 0, null: false
      t.integer :categoria
      t.integer :quantidade, default: 1
      t.integer :ncm, limit: 8
      t.integer :quantidade_minima, default: 1
      t.integer :itens_cx
      t.date :data_validade
      t.references :supplier, foreign_key: true
      t.string :unidade

      t.timestamps
    end
  end
end
