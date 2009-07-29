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

def edit_in_place_echo
  "{html:'#{@echo}'}"
end

# module Perfil
module Perfil
  def geoname
  end
end

post '/perfil/:attr' do
  @echo= params[:new_value]
  edit_in_place_echo
end
# end module Perfil

# geonames 
get '/geoname/:webservice' do
  url = "http://ws.geonames.org/"
  url << params[:webservice]
  url << "?"
  url << request.query_string
  RestClient.get url
end

# end geonames


