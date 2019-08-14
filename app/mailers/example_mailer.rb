class ExampleMailer < ApplicationMailer
	default from: "vgsm98@gmail.com"

  	def sample_email(user)
    	@user = user
    	@url = 'http://localhost:3000/'
    	mail(to: @user.email, subject: 'Sample Email')
  	end
end
