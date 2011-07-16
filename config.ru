#!/usr/bin/env rackup
# encoding: utf-8
#\ -E deployment

require 'http_router'
require 'mustache'

# load paths relative to document root
$: << ::File.dirname(__FILE__)
::Dir.chdir(::File.dirname(__FILE__))

use Rack::Reloader
use Rack::ContentLength
use Rack::ShowExceptions

run HttpRouter.new {
	get('/?').head.to { |env|
		str = Mustache.render("This is {{adverb}} cool.", 'adverb' => 'super')
		[200, {'Content-Type' => 'text/html'}, str]
	}
}
