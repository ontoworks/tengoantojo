require 'spec'
require 'rack/test'
require 'webrat'

app_file = File.join(File.dirname(__FILE__), *%w[.. .. app.rb])
require app_file
# Force the application name because polyglot breaks the auto-detection logic.
Sinatra::Application.app_file = app_file


Webrat.configure do |config|
  config.mode = :selenium
  config.application_port = 4500 # defaults to 3001. Avoid Selenium’s default port, 4444
  config.application_framework = :sinatra  # could also be :merb. Defaults to :rails 
end

class MyWorld
  include Rack::Test::Methods
  include Webrat::Methods
  include Webrat::Matchers

  Webrat::Methods.delegate_to_session :response_code, :response_body

  def app
    Sinatra::Application
  end
end

World(Webrat::Selenium::Matchers)
World{MyWorld.new}
