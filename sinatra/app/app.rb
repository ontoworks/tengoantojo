require 'rubygems'
require 'sinatra'
require 'haml'
require 'rest_client'
require 'uri'

require '../lib/ui'
require '../lib/helper'



get '/' do
  home
end

get '/search/:query' do
  #q='feeds/snippets?q='+URI.escape(params[:query], Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
  site = RestClient::Resource.new('http://www.google.com/base/feeds/snippets')
  puts site.to_s
  site.get
end


