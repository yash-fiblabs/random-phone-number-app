class PhoneNumber < ApplicationRecord
	START_PHONE_NUMBER = 1111111111
	LAST_PHONE_NUMBER = 9999999999

	validates :phone_number, uniqueness: true, presence: true


	def self.allot_phone_number phone_number
		
		phone_number = phone_number.to_i

		phone_number_already_alloted = self.find_by(phone_number: phone_number).present?
		if phone_number_already_alloted.blank? && phone_number > 1111111110 && phone_number < 10000000000
				number = phone_number
		else
			number = rand START_PHONE_NUMBER..LAST_PHONE_NUMBER

			unless self.find_by(phone_number: number).blank?
				number = rand START_PHONE_NUMBER..LAST_PHONE_NUMBER
			end
		end
		alloted_number = self.create(phone_number: number)
		message = ""
		if alloted_number.blank?
			message = "There is some problem in alloting number"
		elsif alloted_number.try(:phone_number).to_i == phone_number.to_i
			message = "Your chosen number is alloted"
		elsif phone_number.present? && phone_number != 0
			message = "Your chosen number is already alloted. So you are alloted with a random number." 
		else
			message = "You didn't chose any number so you are alloted with a random number"
		end
		response = {
			allocation_status: message,
			number: alloted_number.try(:phone_number) 
		}
		response
	end
end
