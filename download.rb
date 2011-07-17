require 'mustache'

require 'open-uri'

class TorrentDownload < Mustache
	attr_reader :title, :name, :type

	def initialize(env)
		@env = Rack::Request.new(env)
		@name = @env.POST["name"]
		@title = "Download for " + @name + " Queued"
		@type = @env.POST["type"]

		download_file
	end

	def get_dir(type)
		{"movie" => ".", "tv" => "."}[type]
	end

	def download_file
		open(get_dir(@type) + "/" + filename, 'w') { |output_file|
			open(URI.escape(@env.POST["enclosure_url"])) { |input_file|
				output_file.write(input_file.read)
			}
		}
	end

	def filename
		@env.POST["hash"] + "-" + File.basename(@env.POST["enclosure_url"])
	end

	def template_file
		'./torrent_download.mustache'
	end
end
