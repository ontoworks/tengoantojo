# post item to Google Base account
get "/items" do
  account=session['user']['google_base_subaccount']
  entry= GData::Atom_Entry.new(:google_product)
  entry.title= "Mi Producto"
  entry.description= "Un producto muy bien descrito"
  entry.author= {:name=> "Santiago Gaviria",
    :email=> "sgaviria@gmail.com"}
  entry.g.item_type= "products"
  entry.g.item_language= "es"
  entry.g.price= "999,999"+" usd"
  entry.g.condition= "new"
  entry.g.product_type= "cosita"

  json_o=RestClient.post couchdb_db_url(:products), "{}"
  entry.g.id= (JSON.parse json_o)["id"]

  data=haml(:atom_entry, :locals=>{:entry => entry})
  RestClient.post "#{GData::Base::GBASE_FEEDS_URL}/#{account}/items", data, GData::GDATA_AUTH_HEADER
end

post '/:user/items' do
  if session['user']['username']==params[:user]
    params['product']['author']={}
    params['product']['author']['name']= "#{session['user']['name']} #{session['user']['last_name']}"
    params['product']['author']['email']= session['user']['email']
    proxy= GData::Base::Feeds_Proxy.new
    proxy.post session['user']['google_base_subaccount'], params['product']
  end
end

get "/:user/items" do
  if session['user']['username']=="santiago"
    proxy= GData::Base::Feeds_Proxy.new
    proxy.get session['user']['google_base_subaccount'], request.query_string
  else
    _post_error "@#{request.path_info} - Unauthorized user"
    redirect '/error', 404
  end
end

get '/search/:query' do
  Rest.get('http://www.google.com/base/feeds/snippets')
end

get '/product.json' do
  RestClient.get "http://www.google.com/base/feeds/snippets?"+request.query_string,:accept => "application/json"
end
