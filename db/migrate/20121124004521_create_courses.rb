class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.integer :office_id
      t.integer :course_type_id
      t.datetime :start
      t.datetime :end
      t.integer :max_occupancy

      t.timestamps
    end
  end
end
