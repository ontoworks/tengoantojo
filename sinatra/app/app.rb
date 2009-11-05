require 'rubygems'
require 'compass'
require 'sinatra'
require 'haml'
require 'rest_client'
require 'uri'
require 'json'

require '../lib/assets_helpers'
require '../lib/ui'
require '../lib/helper'
require 'resources/favorite'

# set sinatra's variables
set :app_file, __FILE__
set :root, File.dirname(__FILE__)

configure :development do
  set :couchdb_server, 'http://127.0.0.1:5984'

  Compass.configuration.parse(File.join(Sinatra::Application.root, 'config', 'compass.config'))
end

# at a minimum, the main sass file must reside within the ./views directory. here, we create a ./views/stylesheets directory where all of the sass files can safely reside.
get '/stylesheets/:name.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass(:"stylesheets/#{params[:name]}", Compass.sass_engine_options )
end

get '/' do
  haml :home
end

get '/search/:query' do
  Rest.get('http://www.google.com/base/feeds/snippets')
end

get '/product.json' do
  RestClient.get "http://www.google.com/base/feeds/snippets?"+request.query_string,:accept => "application/json"
end


post '/item' do
  headers = {
    :Authorization => "AuthSub token=\"CInwwZG2GBDK6ZCFBw\"",
    "X-Google-Key" => "key=ABQIAAAA7VerLsOcLuBYXR7vZI2NjhTRERdeAiwZ9EeJWta3L_JZVS0bOBRIFbhTrQjhHE52fqjZvfabYYyn6A",
    "Content-Type" => "application/atom+xml",
    :accept => "application/atom+xml"
  }

  @entry = Atom_Entry.new(:google)
  @entry.title= "lasagnas bunpum"
  @entry.author= {:name=> "Ontoworks",
                  :email=> "santiago@ontoworks.com"}
  @entry.g.item_type= "receta"
  @entry.g.item_language= "es"
  data= (haml :atom_entry)

  RestClient.post "http://www.google.com/base/feeds/items", data, headers
end

class Atom_Entry
  attr_accessor :id, 
                :creation_time,
                :author,
                :title,
                :link,
                :content,
                :updated,
                :description,
                :modification_time

  def initialize(type)
    # might be redesigned (dynamically?)
    if type == :google
      self.class.send(:attr_accessor, Google_Atom_Entry::NAMESPACE)
    end
    @g= Google_Atom_Entry.new
  end
end

class Google_Atom_Entry
  NAMESPACE="g"
  attr_accessor :application,
                :application_domain,
                :contact_phone,
                :customer_id,
                :expiration_date,
                :image_link,
                :item_language,
                :item_type,
                :label,
                :registered_application,
                :target_country
end

class Google_Entry_Product < Google_Atom_Entry
  attr_accessor :author,
                :brand,
                :color,
                :condition,
                :expiration_date,
                :height,
                :isbn,
                :length,
                :location,
                :model_number,
                :mpn,
                :online_only,
                :payment,
                :payment_notes,
                :price,
                :price_type,
                :product_type,
                :publisher,
                :quantity,
                :size,
                :upc,
                :weight,
                :width,
                :year
end

get '/item' do
  @entry = Atom_Entry.new(:google)
  @entry.title= "lasagnas bu&ntilde;pum"
  @entry.author= {:name=> "Ontoworks",
                  :email=> "santiago@ontoworks.com"}
  @entry.g.item_type= "receta"
  @entry.g.item_language= "es"
  haml :atom_entry
end

#get '/stylesheets/styles.css' do
#  style
#end

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

# global components
get '/marketplace' do
  haml :left
end

get '/social' do
  haml :right
end

get '/geocity' do
end

get '/events' do
end

get '/bedroom' do
end

def couchdb_view_url(db,design,view,*params)
  url="#{options.couchdb_server}/#{db.to_s}/_design/#{design.to_s}/_view/#{view.to_s}"
  if params[0]
    query="?"
    params[0].each do |k,v|
      query << "#{k}=#{v}&"
    end
    query=query.gsub(/&$/,'')
    url << query
  end
  URI.escape(url)
end

def couchdb_doc_url(db,id)
  "#{options.couchdb_server}/#{db.to_s}/#{id}"
end

get '/categories.json' do
  RestClient.get couchdb_view_url(:categories, :tree, :main)
end

get '/categories' do
  embed :category_select
end

get '/categories/:id' do
  @id=params[:id]
  embed :category_select
end

get '/categories/:id/children' do
  query={:startkey=>"[\"#{params[:id]}\"]",:endkey=>"[\"#{params[:id]}\",{}]"}
  o_json=RestClient.get couchdb_view_url(:categories, :tree, :children, query)
  list= (JSON.parse o_json)["rows"]
  category_list=[]
  list.each do |c|
    category_list << {"id"=>c["id"], "key"=>c["value"]}
  end
  haml :category_list, {:locals => { :category_list => category_list } }
end
