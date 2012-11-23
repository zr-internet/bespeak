class CreateCourseTypes < ActiveRecord::Migration
  def change
    create_table :course_types do |t|
      t.string :name
      t.text :description
      t.integer :cost_cents, :default => 0, :null => false

      t.timestamps
    end
  end
end
