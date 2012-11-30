object @course

attributes :id, :course_type_id
node(:start) { |c| c.start.to_i }
node(:end) { |c| c.end.to_i }
child(:office) { attributes :id, :name }
