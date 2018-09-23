class Admin::BaseController < ActionController::Base
	layout 'admin'

	before_action :authorize_admin

	private
	def authorize_admin
		unless current_admin.present?
			flash[:error] = "Access Denied"
			redirect_to admin_root_path
		end
	end
end