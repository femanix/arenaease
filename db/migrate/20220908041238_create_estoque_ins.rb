class CreateEstoqueIns < ActiveRecord::Migration[5.2]
  def change
    create_table :estoque_ins do |t|
      t.references :produto, foreign_key: true
      t.integer :quantidade
      t.integer :preco_compra_cents, default: 0, null: false
      t.references :user, foreign_key: true
      t.references :supplier, null: true, foreign_key: true

      t.timestamps
    end
  end
end
