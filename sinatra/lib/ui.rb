helpers do
  def home
    haml :home
  end

  def head
    haml :head
  end

  def content
    haml :body1
  end

  def product_table
    haml :product_table
  end

  def product_list_home
    haml :product_list
  end
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

get '/ui/product_list' do
  product_list_home
end
