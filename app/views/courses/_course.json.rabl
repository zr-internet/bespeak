object @course

attributes :id, :course_type_id, :office_id
node(:start) { |c| c.start.to_i }
node(:end) { |c| c.end.to_i }
