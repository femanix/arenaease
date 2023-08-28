class CreateMatriculas < ActiveRecord::Migration[6.0]
  def change
    create_table :matriculas do |t|
      t.date :data_matricula
      t.date :validade_exame
      t.date :renovacao
      t.decimal :desconto, precision: 5, scale: 2
      t.references :plano, null: false, foreign_key: true
      t.references :aluno, null: false, foreign_key: true, :unique => true

      t.timestamps
    end
  end
end
