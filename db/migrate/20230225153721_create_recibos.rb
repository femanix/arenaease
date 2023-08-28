class CreateRecibos < ActiveRecord::Migration[6.0]
  def change
    create_table :recibos do |t|
      t.references :aluno, null: false, foreign_key: true
      t.bigint :cpf
      t.integer :valor_cents, default: 0, null: false
      t.string :token
      t.references :mensalidade, null: false, foreign_key: true

      t.timestamps
    end
  end
end
