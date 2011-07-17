require 'mustache'

class TorrentInfo < Mustache
	attr_reader :title, :name, :enclosure_url, :link, :hash
	def initialize(env)
		req = Rack::Request.new(env)
		@title = "Torrent Info"
		if req.GET["title"]
			@title = "Info For " + req.GET["title"]
			@name = req.GET["title"]
			@enclosure_url = req.GET["enclosure_url"]
			@link = req.GET["link"]
			@hash = req.GET["hash"]
		end
	end

	def template_file
		'./torrent_info.mustache'
	end
end
