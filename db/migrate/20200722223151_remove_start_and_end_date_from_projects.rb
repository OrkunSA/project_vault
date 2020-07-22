class RemoveStartAndEndDateFromProjects < ActiveRecord::Migration
  def change
    remove_column :projects, :start_date, :datetime
    remove_column :projects, :end_date, :datetime
  end
end
