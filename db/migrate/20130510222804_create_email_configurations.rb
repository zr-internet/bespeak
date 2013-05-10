class CreateEmailConfigurations < ActiveRecord::Migration
  def change
    create_table :email_configurations do |t|
      t.string 			:from
      t.references 	:site
			
      t.timestamps
    end
		add_index :email_configurations, :site_id
  end
end
