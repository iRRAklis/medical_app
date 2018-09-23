class ContactFormsController < ApplicationController
	def show
	end

	def send_contact_form
		email = { email_address: current_user.email,subject: params[:subject], message: params[:message] }

		if email[:subject].present? && email[:message].present?
			ContactFormMailer.send_contact_form(email).deliver
			@success = true
			render 'show'
		else
			flash[:error] = "Please fill all fields in."
			redirect_to contact_path
		end
	end
end