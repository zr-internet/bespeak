class AddMandrillApiDetailsToEmailConfiguration < ActiveRecord::Migration
  def change
		remove_column :email_configurations, :from
		change_table :email_configurations do |t|
			t.string		:name
			t.string		:key
			t.string		:confirmation_template
			t.string		:reminder_template
		end
  end
end
