class CreateAlunos < ActiveRecord::Migration[6.0]
  def change
    create_table :alunos do |t|
      t.text :nome
      t.date :data_nascimento
      t.integer :rg
      t.integer :cpf, limit: 8
      t.integer :numero
      t.integer :telefone1
      t.integer :telefone2
      t.integer :telefone3
      t.text :responsavel1
      t.text :responsavel2
      t.references :modalidade, null: false, foreign_key: true

      t.timestamps
    end
  end
end
