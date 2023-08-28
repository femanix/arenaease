class AddValorPagoCentsToMensalidade < ActiveRecord::Migration[6.1]
  def change
    add_column :mensalidades, :valor_pago_cents, :integer, default: 0
    add_column :mensalidades, :team_id, :bigint
    add_foreign_key :mensalidades, :teams, column: :team_id, on_delete: :restrict
    change_column_null :mensalidades, :aluno_id, true

  end
end
