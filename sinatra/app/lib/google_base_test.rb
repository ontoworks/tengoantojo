require 'haml'
require 'restclient'

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
  :target_country,

  :condition,
  :price,
  :id

end

def haml(template, locals={})
  Haml::Engine.new(File.read("./views/#{template.to_s}.haml")).render(self,locals)
end

def gb_test
  headers={
    :Authorization => "AuthSub token=\"CInwwZG2GBDa0_J9\"",
    "X-Google-Key" => "key=ABQIAAAA7VerLsOcLuBYXR7vZI2NjhTRERdeAiwZ9EeJWta3L_JZVS0bOBRIFbhTrQjhHE52fqjZvfabYYyn6A",
    "Content-Type" => "application/atom+xml",
    :accept => "application/atom+xml"
  }

  entry = Atom_Entry.new(:google)
  entry.title= "Un producto desde cosiaco"
  entry.description= "Hola Mundo"
  entry.author= {:name=> "Santiago Gaviria",
    :email=> "santiago@ontoworks.com"}
  entry.g.item_type= "products"
  entry.g.item_language= "es"
  entry.g.condition="nuevo"
  entry.g.price="999 cop"
  entry.g.id="9876543210"
  data= haml(:atom_entry_old, :entry=>entry)
  
  RestClient.post "http://www.google.com/base/feeds/6293664/items", data, headers
end
