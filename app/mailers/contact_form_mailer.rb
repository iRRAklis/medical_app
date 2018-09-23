class ContactFormMailer < ApplicationMailer
	 def send_contact_form(email)
  	@subject = email[:subject]
  	@message = email[:message]

  	mail(from: email[:email_address], to: "iposnakidis@gmail.com", subject: "Μήνυμα από τη φόρμα επικοινωνίας")
  end
end