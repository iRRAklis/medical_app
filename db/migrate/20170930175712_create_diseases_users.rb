class CreateDiseasesUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :diseases_users do |t|
    	t.belongs_to :disease, index: true
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
