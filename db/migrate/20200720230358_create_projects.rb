class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.string :platform
      t.string :programming_language
      t.datetime :start_date
      t.datetime :end_date
    end
  end
end
