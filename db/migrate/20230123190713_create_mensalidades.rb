class CreateMensalidades < ActiveRecord::Migration[6.0]
  def change
    create_table :mensalidades do |t|
      t.references :aluno, null: false, foreign_key: true
      t.date :vencimento
      t.integer :value_cents, default: 0, null: false
      t.references :plano, null: false, foreign_key: true
      t.integer :status, default: 0
      t.date :data_pagamento

      t.timestamps
    end
  end
end
