require 'rubygems'
require 'sinatra'
require 'haml'
require '../lib/ui'
require '../lib/helper'

get '/' do
  home
end

get '/ui/product_table' do
  out = ""

  out << (haml <<OUT
!!! Strict
%html{:xmlns=>"http://www.w3.org/1999/xhtml"}
OUT
         )
  out << head
  out << %q{<div class="container container_24">}
  out << product_table*5 << %q{</div>}
end