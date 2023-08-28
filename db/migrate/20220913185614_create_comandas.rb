class CreateComandas < ActiveRecord::Migration[5.2]
  def change
    create_table :comandas do |t|
      t.references :itens_comanda
      t.references :cliente, foreign_key: true
      t.integer :valor_total_cents, default: 0, null: false
      t.integer :status, default: 0
      t.text :observacao

      t.timestamps
    end
  end
end
