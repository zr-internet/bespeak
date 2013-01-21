require 'uri'

class PlainTextParamsFilter
	# Constants
  # Supported Content-Types
  TEXT_PLAIN = 'text/plain'.freeze
	def self.filter(controller)
		return true unless controller.request.content_type == TEXT_PLAIN and controller.request.raw_post.present?
		
		decoded_params = URI::decode_www_form controller.request.raw_post
		controller.params.merge! Hash[decoded_params]
	end
end