class SetUtf8Encoding < ActiveRecord::Migration[5.1]
  def change
  	execute "ALTER TABLE diseases CONVERT TO CHARACTER SET utf8;"
		execute "ALTER TABLE articles CONVERT TO CHARACTER SET utf8;"
		execute "ALTER TABLE users CONVERT TO CHARACTER SET utf8;"
  end
end
