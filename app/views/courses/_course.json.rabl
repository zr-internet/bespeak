object @course

attributes :id, :course_type_id, :office_id
node(:start_at) { |c| c.start_at.to_i }
node(:end_at) { |c| c.end_at.to_i }
node(:timeZoneOffset) { |c| c.start_at.in_time_zone(c.office.time_zone).utc_offset }
