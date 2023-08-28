class AddMensalidadeToCashIns < ActiveRecord::Migration[6.1]
  def change
    add_reference :cash_ins, :mensalidade, null: true, foreign_key: true, on_delete: :cascade
  end
end
