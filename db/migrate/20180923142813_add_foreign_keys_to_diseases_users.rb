class AddForeignKeysToDiseasesUsers < ActiveRecord::Migration[5.1]
  def change
  	add_foreign_key :diseases_users, :diseases
  	add_foreign_key :diseases_users, :users
  end
end
