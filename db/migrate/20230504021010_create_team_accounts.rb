class CreateTeamAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :team_accounts do |t|
      t.references :team, null: false, foreign_key: true
      t.integer :balance_cents, default: 0

      t.timestamps
    end
  end
end
