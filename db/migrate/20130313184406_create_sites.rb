class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :token
      t.string :name

      t.timestamps
    end
  end
end
