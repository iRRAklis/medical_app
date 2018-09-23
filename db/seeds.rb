(1..10).each do |time|
	user = User.new
	user.email = "test#{time}@example.com"
	user.password	= "000000"
	user.password_confirmation = "000000"
	user.full_name = "User #{time}"
	user.amka = rand((10000000000..99999999999))
	user.gender = ["male", "female"].sample
	user.save

	disease = Disease.new
	disease.name = "Disease #{time}"
	disease.probability = rand(1..100)
	disease.save

	article = Article.new
	article.title = "Article #{time}"
	article.body = "This is Article No.#{time}."
	article.save
end

(1..10).each do |time|
	user = User.find(time)
	user.diseases << [Disease.find(rand(1..10)), Disease.find(rand(1..10)), Disease.find(rand(1..10))]

	article = Article.find(time)
	article.diseases << [Disease.find(rand(1..10)), Disease.find(rand(1..10))]
end