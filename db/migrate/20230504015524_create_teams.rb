class CreateTeams < ActiveRecord::Migration[6.1]
  def change
    create_table :teams do |t|
      t.string :nome
      t.references :cliente, null: false, foreign_key: true
      t.references :plano, null: true, foreign_key: true
      t.references :modalidade, null: false, foreign_key: true
      t.boolean :ativo, default: true

      t.timestamps
    end
  end
end
