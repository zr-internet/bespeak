class CreateForms < ActiveRecord::Migration
  def change
    create_table :forms do |t|
      t.string			:name
      t.string 			:template
      t.references	:site
			t.text				:options

      t.timestamps
    end
  end
end
