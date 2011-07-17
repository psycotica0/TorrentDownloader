require 'mustache'

class TorrentDownload < Mustache
	attr_reader :title, :name, :type

	def initialize(env)
		@env = Rack::Request.new(env)
		@name = @env.POST["name"]
		@title = "Download for " + @name + " Queued"
		@type = @env.POST["type"]
	end

	def filename
		@env.POST["hash"] + "-" + File.basename(@env.POST["enclosure_url"])
	end

	def template_file
		'./torrent_download.mustache'
	end
end
