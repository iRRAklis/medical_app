class ErrorsController < ApplicationController
	def page_not_found
		respond_to do |type|
			type.html { render template: "errors/404", layout: "error", status: 404 }
			type.all  { render nothing: true, status: 404 }
		end
	end

	def internal_server_error
		respond_to do |type|
			type.html { render template: "errors/500", layout: "error", status: 500 }
			type.all  { render nothing: true, status: 500 }
		end
	end
end