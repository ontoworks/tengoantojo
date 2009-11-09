def couchdb_view_url(db,design,view,*params)
  url="#{options.couchdb_server}/#{db.to_s}/_design/#{design.to_s}/_view/#{view.to_s}"
  if params[0]
    query="?"
    params[0].each do |k,v|
      query << "#{k}=#{v}&"
    end
    query=query.gsub(/&$/,'')
    url << query
  end
  URI.escape(url)
end

def couchdb_doc_url(db,id)
  "#{options.couchdb_server}/#{db.to_s}/#{id}"
end