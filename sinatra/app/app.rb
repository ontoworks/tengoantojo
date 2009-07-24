require 'rubygems'
require 'sinatra'
require 'haml'
require 'rest_client'
require 'uri'

require '../lib/assets_helpers'
require '../lib/ui'
require '../lib/helper'

get '/' do
  home
end

get '/search/:query' do
  Rest.get('http://www.google.com/base/feeds/snippets')
end

get '/designer' do
  haml :designer
end

get '/product.json' do
  RestClient.get "http://www.google.com/base/feeds/snippets?"+request.query_string,:accept => "application/json"
end
