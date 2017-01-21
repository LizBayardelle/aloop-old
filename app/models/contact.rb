class Contact < ActiveRecord::Base
  	belongs_to :user
  	after_create :send_email

	private

	def send_email
		ContactMailer.new_contact_us_submission(self).deliver_now
	end
end
