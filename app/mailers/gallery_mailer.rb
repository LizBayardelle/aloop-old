class GalleryMailer < ApplicationMailer
	default from: "sales@aloop.com"

	def submission_approved(user, photo)
		@user = user
		@photo = photo

		mail(to: user.email, subject: "Your Awesome Bike is Now on Display")
	end
end
