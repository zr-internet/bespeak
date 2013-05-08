class AddSiteIdToCustomer < ActiveRecord::Migration
  def change
		change_table :customers do |t|
			t.references	:site
			t.index 			:site_id
		end
  end
end
