require 'sinatra'
require 'sinatra/async'
require 'app'

#  enable :sessions

#  configure :development do
#    set :couchdb_server, 'http://localhost:5984'
#    set :error_log_url, 'http://localhost:5984/errors'
#  end

  # set sinatra's variables
#  set :app_file, __FILE__
#  set :root, File.dirname(__FILE__)

class AsyncRoutes < Sinatra::Application
  register Sinatra::Async

  enable :sessions
  enable :show_exceptions

  configure :development do
    set :couchdb_server, 'http://localhost:5984'
    set :error_log_url, 'http://localhost:5984/errors'
  end

  # set sinatra's variables
  set :app_file, __FILE__
  set :root, File.dirname(__FILE__)

  apost '/bosh/chat' do
    r= RestClient::Resource.new "http://192.168.1.1:5280/http-bind", :timeout=>61
    response= r.post(request.body.string)
    body response
  end
end

post '/chat' do
  r= RestClient::Resource.new "http://192.168.1.1:5280/http-bind", :timeout=>61
  response= r.post(params[:body])
  #body response
end

run AsyncRoutes
#run Sinatra::Application
