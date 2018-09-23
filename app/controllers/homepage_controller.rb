class HomepageController < ApplicationController
	def index

	end

	def resource
		@resource ||= User.new
	end
end
