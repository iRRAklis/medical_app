class SetDefaultToUsersFatherAmkaAndMotherAmka < ActiveRecord::Migration[5.1]
  def change
  	change_column :users, :father_amka, :string, default: ""
  	change_column :users, :mother_amka, :string, default: ""
  end
end
