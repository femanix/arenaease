class ChangeIntegerLimitiInAlunos < ActiveRecord::Migration[6.0]
  def change
    change_column :alunos, :telefone1, :integer, limit: 8
    change_column :alunos, :telefone2, :integer, limit: 8
    change_column :alunos, :telefone3, :integer, limit: 8
  end
end
