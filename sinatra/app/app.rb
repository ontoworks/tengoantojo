require 'rubygems'
require 'sinatra'
require 'haml'
require 'rest_client'
require 'uri'

require '../lib/ui'
require '../lib/helper'
require '../lib/rest'
require '../lib/designer'


get '/' do
  home
end

get '/search/:query' do
  #q='feeds/snippets?q='+URI.escape(params[:query], Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
  Rest.get('http://www.google.com/base/feeds/snippets')
end

get '/designer' do
  haml :designer
end

get '/product' do
  RestClient.get "http://www.google.com/base/feeds/snippets?"+request.query_string,:accept => "application/json"
end
