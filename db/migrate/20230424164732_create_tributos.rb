class CreateTributos < ActiveRecord::Migration[6.1]
  def change
    create_table :tributos do |t|
      t.integer :origem
      t.string :ncm
      t.string :cest
      t.string :cst
      t.string :cfop
      t.integer :pis_cst
      t.integer :confis_cst
      t.references :produto, null: false, foreign_key: true

      t.timestamps
    end
  end
end
