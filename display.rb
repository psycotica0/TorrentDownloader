require 'mustache'

require 'json'
require 'open-uri'
require 'uri'

class TorrentDisplay < Mustache
	def initialize(env)
		@title = "Mediabox Search"
		req = Rack::Request.new(env)
		if req.GET["q"]
			request(req.GET["q"])
		end
	end

	def request(query)
		@title = "Mediabox Search -- " + query
		@query = query
		open("http://isohunt.com/js/json.php?ihq=" + URI.escape(query) + "&rows=20") { |file|
			@list = JSON::parse(file.read)["items"]["list"]
			# Add the info link
			@list.each { |item|
				item["info_link"] = "/info?title=" + URI.escape(item["title"]) + "&enclosure_url=" + URI.escape(item["enclosure_url"]) + "&link=" + URI.escape(item["link"])
			}
		}
	end

	def query
		@query
	end

	def list
		@list
	end

	def list_empty
		@list.nil?
	end

	def title
		@title
	end

	def template_file
		'./torrent_display.mustache'
	end
end
