class CarrierwaveStringIO < StringIO
  def original_filename
    "#{Time.now}.#{extension}"
  end

  def content_type
    "image/#{extension}"
  end

  def extension
  	ApiImageHelper.class_variable_get(:@@api_image_helper).image_type
  end
end
