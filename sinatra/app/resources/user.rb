post "/login" do
  
end

post "/users" do
  user={
   "username"=> params['user']['username'],
   "password"=> params['user']['password'],
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

  RestClient.post couchdb_db_url(:users), user.to_json
end
