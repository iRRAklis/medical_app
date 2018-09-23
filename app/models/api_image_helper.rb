# Helper Class for CarrierwaveStringIo instances

class ApiImageHelper
	def initialize(base64_data, object)
		@base64_data = base64_data
		@object 		 = object
	end

	def image_type
  	@base64_data.split(";").first.split("/").last
  end

  def image_data
  	@base64_data.split(",").last
  end

  # Set class variable in order to be used from CarrierwaveStringIo instance
  def set_class_variable!
  	@@api_image_helper = self
  end

  def reset_class_variable!
  	@@api_image_helper = nil
  end
end
