require 'rubygems'
require 'haml'
require 'sass'
require 'sinatra'
require 'rest_client'
require 'uri'
require 'json'

enable :sessions

# set sinatra's variables
set :app_file, __FILE__
set :root, File.dirname(__FILE__)

require 'lib/couchdb'
require 'lib/google_base'
require 'lib/assets_helpers'
require 'lib/ui'
require 'lib/helper'

#require "dm-core"
#require "sinatra-authentication"

#use Rack::Session::Cookie, :secret => 'A1 sauce 1s so good you should use 1t on a11 yr st34ksssss'

configure :development do
  set :couchdb_server, 'http://127.0.0.1:5984'
  set :error_log_url, 'http://127.0.0.1:5984/errors'
end

def _post_error(msg)
  RestClient.post options.error_log_url, {:path=>request.path_info,:msg=>msg}.to_json
end


get '/stylesheets/:name.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass "stylesheets/#{params[:name]}".to_sym
end

get '/' do
  session["user"]={"username"=>"santiago",
                   "name"=>"Santiago",
                   "last_name"=>"Gaviria",
                   "email"=>"sgaviria@gmail.com",
                   "google_base_subaccount"=>"6293664"}
  haml :home
end

def edit_in_place_echo(echo)
  {:html=>echo}.to_json
end

post '/perfil/:attr' do
  edit_in_place_echo params[:new_value]
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

load 'resources/user.rb'
load 'resources/favorite.rb'
load 'resources/category.rb'
load 'resources/item.rb'
