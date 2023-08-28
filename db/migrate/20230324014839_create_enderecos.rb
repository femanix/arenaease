class CreateEnderecos < ActiveRecord::Migration[6.0]
  def change
    create_table :enderecos do |t|
      t.references :aluno, null: false, foreign_key: true
      t.string :rua
      t.integer :numero
      t.string :bairro
      t.string :cidade
      t.string :estado
      t.string :cep

      t.timestamps
    end
  end
end
