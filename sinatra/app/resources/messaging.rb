# user sends a message to friend
post '/:user/friends/:friend' do
  enqueue("chat_server_bus", {:to=>params[:friend], :from=>params[:user], :msg=>params[:msg]})
  "message from #{params[:user]} to #{params[:friend]}"
end

get '/:user/conversations' do
  if params[:user]==session['user']['username']
    query= "[item type:conversations]"
    proxy= GData::Base::Items_Proxy.new
    proxy.get "6197858", {:bq=>query, :alt=>"json"}
  end
end

post '/bosh/chato' do
  r= RestClient::Resource.new "http://poor-kid:5280/http-bind", :timeout=>61
  r.post request.body.string
end
