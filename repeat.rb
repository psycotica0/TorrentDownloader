require 'mustache'

class AdverbRepeat < Mustache
	def initialize(env)
		@env = Rack::Request.new(env)
	end

	def adverb
		@env.GET["adverb"] || "super"
	end

	def template
		"This is {{adverb}} cool!"
	end
end
