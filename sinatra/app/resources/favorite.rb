#
# couchdb crud for favorite resource
#

#
# get all 'favoritos' documents
#
get '/favoritos' do
  @favoritos=RestClient::Resource.new("#{options.couchdb_server}/favoritos")
  @favoritos["/_all_docs"].get
end

#
# get a favorite by id
#
get '/favoritos/:id' do
  @favoritos=RestClient::Resource.new("#{options.couchdb_server}/favoritos")
  @favoritos[params[:id]].get
end

post '/favoritos/:id' do
  @favoritos=RestClient::Resource.new("#{options.couchdb_server}/favoritos")
  @favoritos.post request.body.string
end

put '/favoritos/:id' do
  @favoritos=RestClient::Resource.new("#{options.couchdb_server}/favoritos")
  exists=false
  begin
    exists=@favoritos[params[:id]].get
  rescue
    write "no existe"
  end
  unless exists
    @favoritos[params[:id]].put request.body.string
  else
    rev=(JSON.parse exists)["_rev"]
    doc=(JSON.parse request.body.string)
    doc["_rev"]=rev
    @favoritos[params[:id]].put doc.to_json
  end
end

delete '/favoritos/:id' do
  @favoritos=RestClient::Resource.new("#{options.couchdb_server}/favoritos")
  exists=false
  begin
    exists=@favoritos[params[:id]].get
  rescue
    write "no existe, pero 'q importa"
  end
  if exists
    rev=(JSON.parse exists)["_rev"]
    @favoritos[params[:id]+"?rev="+rev].delete
  end
end
