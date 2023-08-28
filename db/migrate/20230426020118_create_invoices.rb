class CreateInvoices < ActiveRecord::Migration[6.1]
  def change
    create_table :invoices do |t|
      t.references :comanda, null: false, foreign_key: true
      t.string :nota_chave
      t.string :nota_numero
      t.integer :valor_cents, default: 0, null: false
      t.string :nota_status
      t.string :nota_situacao
      t.string :nota_pdf
      t.string :nota_xml

      t.timestamps
    end
  end
end
