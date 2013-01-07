class RenameCourseStartAndEnd < ActiveRecord::Migration
  def change
		rename_column	:courses, :start, :start_at
		rename_column	:courses, :end, :end_at
  end
end
