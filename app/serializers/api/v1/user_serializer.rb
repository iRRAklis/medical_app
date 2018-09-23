class Api::V1::UserSerializer < ActiveModel::Serializer
  attributes :email, :amka, :full_name, :diseases, :disease_probability, :father_name, :father_amka,
  					 :mother_name, :mother_amka, :suggested_articles, :image_url, :authentication_token

  def father_name
  	if object.respond_to?(:object)
  		object.object.father.try(:full_name)
  	else
  		object.father.try(:full_name)
  	end
  end

  def mother_name
  	if object.respond_to?(:object)
  		object.object.mother.try(:full_name)
  	else
  		object.mother.try(:full_name)
  	end
  end

  def suggested_articles
    if object.respond_to?(:object)
      suggested_articles = object.object.suggested_articles
    else
      suggested_articles = object.suggested_articles
    end

    ActiveModel::Serializer::CollectionSerializer.new(suggested_articles.to_a, serializer: Api::V1::ArticleSerializer)
  end

  def image_url
    if object.respond_to?(:object)
      object.object.image.thumb.url if object.object.image?
    else
      object.image.thumb.url if object.image?
    end
  end
end
