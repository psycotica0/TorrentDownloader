#!/usr/bin/env rackup
# encoding: utf-8
#\ -E deployment

require 'http_router'

# load paths relative to document root
$: << ::File.dirname(__FILE__)
::Dir.chdir(::File.dirname(__FILE__))

use Rack::Reloader
use Rack::ContentLength
use Rack::ShowExceptions

run HttpRouter.new {
	get('/?').head.to { |env|
		require 'display'
		[200, {'Content-Type' => 'text/html'}, TorrentDisplay.new(env).render]
	}
	get('/info').head.to { |env|
		require 'info'
		[200, {'Content-Type' => 'text/html'}, TorrentInfo.new(env).render]
	}
	post('/download').to { |env|
		require 'download'
		[202, {'Content-Type' => 'text/html'}, TorrentDownload.new(env).render]
	}
}
