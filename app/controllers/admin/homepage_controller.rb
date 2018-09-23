class Admin::HomepageController < Admin::BaseController
	skip_before_action :authorize_admin
	
	def index
	end
end