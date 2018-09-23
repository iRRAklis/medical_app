class CreateArticlesDiseases < ActiveRecord::Migration[5.1]
  def change
    create_table :articles_diseases do |t|
      t.belongs_to :article, index: true
      t.belongs_to :disease, index: true
      t.timestamps
    end
  end
end
