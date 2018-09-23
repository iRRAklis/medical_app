class ApplicationController < ActionController::Base
	# protect_from_forgery with: :exception

	protect_from_forgery with: :null_session

	before_action :configure_permitted_parameters, if: :devise_controller?

	def configure_permitted_parameters
		update_attrs = [:password, :password_confirmation, :current_password]
		devise_parameter_sanitizer.permit :account_update, keys: update_attrs
	end

	def after_sign_in_path_for(resource)
		request.referer.include?("admin") ? admin_root_path : user_path(resource)
	end

	def after_sign_out_path_for(resource)
		request.referer.include?("admin") ? admin_root_path : root_path
	end

	# before_action :configure_permitted_parameters, if: :devise_controller?

	# protected
	# def configure_permitted_parameters
	#	 # devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation) }
	#	 devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation])
	# end
end
