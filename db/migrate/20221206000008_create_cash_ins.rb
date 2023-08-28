class CreateCashIns < ActiveRecord::Migration[6.0]
  def change
    create_table :cash_ins do |t|
      t.string :description
      t.string :origin, default: 'Receita Avulsa'
      t.integer :value_cents, default: 0, null: false
      t.integer :method
      t.date :date

      t.timestamps
    end
  end
end
