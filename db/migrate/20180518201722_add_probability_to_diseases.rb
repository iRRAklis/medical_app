class AddProbabilityToDiseases < ActiveRecord::Migration[5.1]
  def change
  	add_column :diseases, :probability, :decimal, precision: 4, scale: 1, after: :name
  end
end
