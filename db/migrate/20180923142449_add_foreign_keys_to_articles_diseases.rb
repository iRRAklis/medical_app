class AddForeignKeysToArticlesDiseases < ActiveRecord::Migration[5.1]
  def change
  	add_foreign_key :articles_diseases, :articles
  	add_foreign_key :articles_diseases, :diseases
  end
end
