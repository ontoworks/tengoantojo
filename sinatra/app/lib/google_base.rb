module CouchDB
  COUCHDB_SERVER= 'http://127.0.0.1:5984'

  def post_database(db, data)
    RestClient.post "#{COUCHDB_SERVER}/#{db}", data
  end
end

module GData
  GDATA_AUTH_HEADER=
    {
    :Authorization => "AuthSub token=\"CInwwZG2GBDa0_J9\"",
    "X-Google-Key" => "key=ABQIAAAA7VerLsOcLuBYXR7vZI2NjhTRERdeAiwZ9EeJWta3L_JZVS0bOBRIFbhTrQjhHE52fqjZvfabYYyn6A",
    "Content-Type" => "application/atom+xml",
    :accept => "application/atom+xml"
  }
  
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
      case type
      when :google
        self.class.send(:attr_accessor, Google_Atom_Entry::NAMESPACE)
        self.send("#{Google_Atom_Entry::NAMESPACE}=",Google_Atom_Entry.new)
      when :google_product
        self.class.send(:attr_accessor, GData::Base::Google_Entry_Product::NAMESPACE)
        self.send("#{GData::Base::Google_Entry_Product::NAMESPACE}=",GData::Base::Google_Entry_Product.new)
      end
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

  def client_login
    headers = {"Content-Type" => "application/x-www-form-urlencoded"}
    RestClient.post "","accountType=HOSTED_OR_GOOGLE&Email=jondoe@gmail.com&Passwd=north23AZ&service=cl&source=Gulp-CalGulp-1.05&logintoken=DQAAAGgA...dkI1LK9&logincaptcha=brinmar"
  end

  module Base
    GBASE_URL= "http://www.google.com/base"
    GBASE_SNIPPETS_URL= "#{GBASE_URL}/snippets"
    GBASE_FEEDS_URL= "#{GBASE_URL}/feeds"
    
    class Feeds_Proxy
      include CouchDB

      def haml(template, locals={})
        Haml::Engine.new(File.read("./views/#{template.to_s}.haml")).render(self, locals)
      end

      def get(account)
        RestClient.get "#{GBASE_FEEDS_URL}/#{account}/items", GDATA_AUTH_HEADER
      end
      
      def post(account,item)
        entry = Atom_Entry.new(:google_product)
        entry.author= {:name=> item['author']['name'],
          :email=> item['author']['email']}
        entry.title= item['name']
        entry.content= item['description']
        entry.g.item_type= "products"
        entry.g.item_language= "es"
        entry.g.price= item['price']+" cop"
        entry.g.condition= item['condition']
        entry.g.product_type= item['category']

        json_o=post_database(:products, "{}")
        entry.g.id= (JSON.parse json_o)["id"]

        data= haml(:atom_entry, :entry => entry)

        RestClient.post "#{GBASE_FEEDS_URL}/#{account}/items", data, GDATA_AUTH_HEADER
      end
    end    
    
    class Google_Entry_Product < Google_Atom_Entry
      attr_accessor :id,
      :author,
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
  end
end
