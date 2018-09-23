class Api::V1::ArticleSerializer < ActiveModel::Serializer
	attributes :title, :body, :image_url

	def image_url
		object.image.thumb.url if object.image?
	end
end