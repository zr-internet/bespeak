class SiteRelationships < ActiveRecord::Migration
  def change
		change_table :courses do |t|
			t.references	:site
			t.index 			:site_id
			t.index				:start_at, order: :asc
			t.index				:course_type_id
			t.index				:office_id
		end
		
		change_table :offices do |t|
			t.references	:site
			t.index 			:site_id
		end
		
		change_table :course_types do |t|
			t.references	:site
			t.index 			:site_id
		end
  end

end
