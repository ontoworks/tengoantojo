require 'rubygems'
require 'sinatra'
require 'haml'
require 'rest_client'
require 'uri'
require 'json'

# set sinatra's variables
set :app_file, __FILE__
set :root, File.dirname(__FILE__)

require '../lib/assets_helpers'
require '../lib/ui'
require '../lib/helper'
require '../lib/couchdb'
require '../lib/google_base'

configure :development do
  set :couchdb_server, 'http://127.0.0.1:5984'
end

get '/stylesheets/:name.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass "stylesheets/#{params[:name]}".to_sym
end

get '/' do
  haml :home
end


def edit_in_place_echo
  "{html:'#{@echo}'}"
end

post '/perfil/:attr' do
  @echo= params[:new_value]
  edit_in_place_echo
end

# geonames 
get '/geoname/:webservice' do
  url = "http://ws.geonames.org/"
  url << params[:webservice]
  url << "?"
  url << request.query_string
  RestClient.get url
end
# end geonames

# global components
get '/marketplace' do
  haml :marketplace
end

get '/social' do
  haml :social
end

load 'resources/favorite.rb'
load 'resources/category.rb'
