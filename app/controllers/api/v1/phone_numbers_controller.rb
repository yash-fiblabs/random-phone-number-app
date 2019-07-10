class Api::V1::PhoneNumbersController < ApplicationController

	def index
		@response = PhoneNumber.allot_phone_number params[:phone_number]
		render json: {response: @response}
	end
end
