post '/login' do
  login(params[:email],params[:password])
  
  if login["success"]
    session["user"]={
      "name"=>"Santiago",
      "last_name"=>"Gaviria",
      "email"=>"sgaviria@gmail.com",
      "google_base_subaccount"=>"6293664"}
  else
  end
end

get '/logout' do
  session["user"]=nil
end

post '/signup' do
  signup(params['email'],params['password'])
end

def update_user
{
   "name"=> params['user']['name'],
   "last_name"=> params['user']['last_name'],
   "legal_id"=> params['user']['legal_id'],
   "landline_phone"=> params['user']['landline_phone']||nil,
   "mobile_phone"=> params['user']['mobile_phone']||nil,
   "email"=> params['user']['email'],
   "street_address"=> params['user']['street_address'],
   "latlng"=> params['user']['latlng'],
   "google_base_subaccount"=> params['user']['google_base_subaccount']||nil
  }
end
