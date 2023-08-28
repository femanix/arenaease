class CreateEstoqueOuts < ActiveRecord::Migration[5.2]
  def change
    create_table :estoque_outs do |t|
      t.references :produto, foreign_key: true
      t.integer :quantidade
      t.references :user, foreign_key: true
      t.string :origem

      t.timestamps
    end
  end
end
