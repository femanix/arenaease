class CreateCashOuts < ActiveRecord::Migration[6.0]
  def change
    create_table :cash_outs do |t|
      t.string :description
      t.string :category
      t.decimal :value_cents, default: 0, null: false
      t.string :method
      t.date :expiration
      t.date :payment_date
      t.string :supplier

      t.timestamps
    end
  end
end
