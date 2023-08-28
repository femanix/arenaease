class AddDeletedAtToCashIns < ActiveRecord::Migration[6.1]
  def change
    add_column :cash_ins, :deleted_at, :datetime
    add_index :cash_ins, :deleted_at

    add_column :cash_outs, :deleted_at, :datetime
    add_index :cash_outs, :deleted_at

    add_column :mensalidades, :deleted_at, :datetime
    add_index :mensalidades, :deleted_at

    add_column :teams, :deleted_at, :datetime
    add_index :teams, :deleted_at

    add_column :team_accounts, :deleted_at, :datetime
    add_index :team_accounts, :deleted_at
  end
end
