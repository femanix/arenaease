class CreatePlanos < ActiveRecord::Migration[6.0]
  def change
    create_table :planos do |t|
      t.references :modalidade, null: false, foreign_key: true
      t.string :descricao
      t.integer :valor_cents, default: 0, null: false

      t.timestamps
    end
  end
end
