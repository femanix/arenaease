class CreateSuppliers < ActiveRecord::Migration[6.0]
  def change
    create_table :suppliers do |t|
      t.string :description
      t.bigint :cnpj

      t.timestamps
    end
  end
end
