require 'rubygems'
require 'sinatra'
require 'haml'
require 'rest_client'
require 'uri'

require '../lib/ui'
require '../lib/helper'
require '../lib/rest'


get '/' do
  home
end

get '/search/:query' do
  #q='feeds/snippets?q='+URI.escape(params[:query], Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
  Rest.get('http://www.google.com/base/feeds/snippets')
end


