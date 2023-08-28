class AddClassScheduleToMatriculas < ActiveRecord::Migration[6.0]
  def change
    add_column :matriculas, :class_schedule, :string
  end
end
