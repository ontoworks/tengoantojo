require 'rubygems'
require 'sinatra'
require 'haml'
require '../lib/ui'
require '../lib/helper'

get '/' do
  home
end

