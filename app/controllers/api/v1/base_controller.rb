class Api::V1::BaseController < ApplicationController
	before_action :authenticate_user

	def authenticate_user
		email = params[:session][:email] rescue nil
		token = params[:session][:authentication_token] rescue nil
		user  = User.where(email: email, authentication_token: token)

		head(:unauthorized) if email.blank? || token.blank? || user.blank?
	end
end