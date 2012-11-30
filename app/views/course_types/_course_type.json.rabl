object @course_type

attributes :id, :name, :description
node(:cost) { |course_type| course_type.cost.to_s }