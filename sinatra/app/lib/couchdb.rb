module CouchDBHelpers
  COUCHDB_SERVER= 'http://127.0.0.1:5984'
  
  def post_database(db, data)
    RestClient.post "#{COUCHDB_SERVER}/#{db}", data
  end

  def post_db(db, data)
    RestClient.post couchdb_db_url(db), data.to_json
  end

  def query_view(db,design,view,*params)
    r=RestClient.get couchdb_view_url(db,design,view,params)
    data=JSON.parse r
    if data["rows"].empty?
      false
    else
      data
    end
  end

  def couchdb_db_url(db)
    url="#{options.couchdb_server}/#{db.to_s}"
  end
  
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
end
