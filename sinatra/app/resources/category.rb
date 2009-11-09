get '/categories.json' do
  RestClient.get couchdb_view_url(:categories, :tree, :main)
end

get '/categories' do
  embed :category_select
end

get '/categories/:id' do
  @id=params[:id]
  embed :category_select
end

get '/categories/:id/children' do
  query={:startkey=>"[\"#{params[:id]}\"]",:endkey=>"[\"#{params[:id]}\",{}]"}
  o_json=RestClient.get couchdb_view_url(:categories, :tree, :children, query)
  list= (JSON.parse o_json)["rows"]
  category_list=[]
  list.each do |c|
    category_list << {"id"=>c["id"], "key"=>c["value"]}
  end
  haml :category_list, {:locals => { :category_list => category_list } }
end
