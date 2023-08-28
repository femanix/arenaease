class AddStatusToMatriculas < ActiveRecord::Migration[6.1]
  def change
    add_column :matriculas, :status, :integer, default: 0
  end
end
