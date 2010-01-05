module CouchDB
  COUCHDB_SERVER= 'http://192.168.1.1:5984'

  def post_database(db, data)
    RestClient.post "#{COUCHDB_SERVER}/#{db.to_s}", data
  end
end

module GData
  GDATA_AUTH_HEADER=
    {
    :Authorization => "AuthSub token=\"CInwwZG2GBDa0_J9\"",
    "X-Google-Key" => "key=ABQIAAAA7VerLsOcLuBYXR7vZI2NjhTRERdeAiwZ9EeJWta3L_JZVS0bOBRIFbhTrQjhHE52fqjZvfabYYyn6A",
    "Content-Type" => "application/atom+xml",
    :accept => "application/atom+xml",
    "GData-Version" => 2
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
        self.class.send(:attr_accessor, Google_Base_Entry::NAMESPACE)
        self.send("#{Google_Base_Entry::NAMESPACE}=",Google_Base_Entry.new)
      when :google_product
        self.class.send(:attr_accessor, GData::Base::Google_Entry_Product::NAMESPACE)
        self.send("#{GData::Base::Google_Entry_Product::NAMESPACE}=",GData::Base::Google_Entry_Product.new)
      when :google_conversation
        self.class.send(:attr_accessor, GData::Base::Google_Entry_Product::NAMESPACE)
        self.send("#{GData::Base::Google_Entry_Product::NAMESPACE}=",GData::Base::Google_Entry_Product.new)	
      end
    end
  end
  
  class Google_Base_Entry
    NAMESPACE="g"
    attr_accessor :id,
                  :application,
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
    GDATA_AUTH_HEADER_JSON=
      {
      :Authorization => "AuthSub token=\"CInwwZG2GBDa0_J9\"",
      "X-Google-Key" => "key=ABQIAAAA7VerLsOcLuBYXR7vZI2NjhTRERdeAiwZ9EeJWta3L_JZVS0bOBRIFbhTrQjhHE52fqjZvfabYYyn6A",
      "Content-Type" => "application/json",
      :accept => "application/json",
      "GData-Version" => 2,
      "If-None-Match" => "W/\"CEYBQn04fSp7ImA9WxBSFUQ.\""
    }

    class Snippets_Proxy
      def get
      end
      
      def get_json
      end
    end

    class Items_Proxy
      include CouchDB
      
      def initialize(options={})
        @tpl_dir= options.delete(:tpl_dir) || "./views"
      end

      def haml(template, locals={})
        tpl= "#{@tpl_dir.to_s}/#{template.to_s}.haml"
        Haml::Engine.new(File.read(tpl)).render(self, locals)
      end

      def get(account,qs={})
        headers= qs[:alt]=="json" ? GDATA_AUTH_HEADER_JSON : GDATA_AUTH_HEADER
        query_string= ""
        qs.each {|k,v| query_string << "#{k}=#{v}&" }
        url= "#{GBASE_FEEDS_URL}/#{account}/items?"
        url << URI.escape("#{query_string}")
        RestClient.get url, headers
      end
      
      def get_json(account)
        get(account,{:alt=>"json"})
      end

      def put(account, item)
        entry=product_atom_entry(item);
        entry.g.id= item["uuid"]
        data= haml(:atom_entry, :entry => entry)
        item['uuid']+"----"+data
#        RestClient.put "#{GBASE_FEEDS_URL}/#{account}/items/#{item['uuid']}", data, GDATA_AUTH_HEADER
      end

      def post(account,item)
	entry= render_atom_entry(item)
	# save id to couchdb
	# this should not go here
        json_o= post_database(item["item_type"], "{}")
        entry.g.id= (JSON.parse json_o)["id"]

	data= haml(:atom_entry, :entry => entry)
	RestClient.post "#{GBASE_FEEDS_URL}/#{account}/items", data, GDATA_AUTH_HEADER
      end

      private
      def render_atom_entry(item)
        entry= Atom_Entry.new(:google)
        entry.title= item['title']
        entry.content= item['description']
        entry.g.item_type= item['item_type']
        entry.g.item_language= item['item_language']
	# products
	if item["item_type"]=="products"
	  entry.g.price= item['price']+" cop"
	  entry.g.condition= item['condition']
	  entry.g.product_type= item['category']
	end
	entry
      end
    end    
        
    class Google_Entry_Product < Google_Base_Entry
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
  end
end
