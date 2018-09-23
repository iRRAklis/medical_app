class Api::V1::ContactFormsController < Api::V1::BaseController
	def send_contact_form
		if ContactFormMailer.send_contact_form(params[:email]).deliver
			render json: { success: "Message successfully sent" }, status: :ok
		end
	end
end