module Imageable
	extend ActiveSupport::Concern

	included do
		mount_uploader :image, ImageUploader
  end
end