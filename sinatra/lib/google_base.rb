class Atom_Entry
  attr_accessor :id, 
                :creation_time,
                :author,
                :title,
                :link,
                :content,
                :updated,
                :description,
                :modification_time

  def initialize(type)
    # might be redesigned (dynamically?)
    if type == :google
      self.class.send(:attr_accessor, Google_Atom_Entry::NAMESPACE)
    end
    @g= Google_Atom_Entry.new
  end
end

class Google_Atom_Entry
  NAMESPACE="g"
  attr_accessor :application,
                :application_domain,
                :contact_phone,
                :customer_id,
                :expiration_date,
                :image_link,
                :item_language,
                :item_type,
                :label,
                :registered_application,
                :target_country
end

class Google_Entry_Product < Google_Atom_Entry
  attr_accessor :author,
                :brand,
                :color,
                :condition,
                :expiration_date,
                :height,
                :isbn,
                :length,
                :location,
                :model_number,
                :mpn,
                :online_only,
                :payment,
                :payment_notes,
                :price,
                :price_type,
                :product_type,
                :publisher,
                :quantity,
                :size,
                :upc,
                :weight,
                :width,
                :year
end

get '/item' do
  @entry = Atom_Entry.new(:google)
  @entry.title= "lasagnas bu&ntilde;pum"
  @entry.author= {:name=> "Ontoworks",
                  :email=> "santiago@ontoworks.com"}
  @entry.g.item_type= "receta"
  @entry.g.item_language= "es"
  haml :atom_entry
end

get '/search/:query' do
  Rest.get('http://www.google.com/base/feeds/snippets')
end

get '/product.json' do
  RestClient.get "http://www.google.com/base/feeds/snippets?"+request.query_string,:accept => "application/json"
end

# post item to Google Base account
post '/item' do
  headers = {
    :Authorization => "AuthSub token=\"CInwwZG2GBDK6ZCFBw\"",
    "X-Google-Key" => "key=ABQIAAAA7VerLsOcLuBYXR7vZI2NjhTRERdeAiwZ9EeJWta3L_JZVS0bOBRIFbhTrQjhHE52fqjZvfabYYyn6A",
    "Content-Type" => "application/atom+xml",
    :accept => "application/atom+xml"
  }

  @entry = Atom_Entry.new(:google)
  @entry.title= "lasagnas bunpum"
  @entry.author= {:name=> "Ontoworks",
                  :email=> "santiago@ontoworks.com"}
  @entry.g.item_type= "receta"
  @entry.g.item_language= "es"
  data= (haml :atom_entry)

  RestClient.post "http://www.google.com/base/feeds/items", data, headers
end
