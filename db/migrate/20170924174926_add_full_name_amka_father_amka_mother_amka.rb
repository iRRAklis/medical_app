class AddFullNameAmkaFatherAmkaMotherAmka < ActiveRecord::Migration[5.1]
  def change
  	add_column :users, :full_name, :string
    add_column :users, :amka, :string
    add_column :users, :father_amka, :string
    add_column :users, :mother_amka, :string
  end
end
