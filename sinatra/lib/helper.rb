helpers do
  include UIHelpers
  include AssetsHelpers

  def haml_times(tpl, n)
    html=""
    n.times do |i|
      @i=i
      html=html+(haml tpl.to_sym)
    end
    html
  end

  def mock_products(count)
    #render_haml("%div.product-overlay")+(product_table)*count
    product_list(count)
  end

  def product_list(count)
    list = ""
    count.times do |i|
      @id="product-"+i.to_s
      list << product
    end
    if count == 0
      list << (haml :empty_list)      
      list << (product :klass => [:hidden])
    end
    list
  end

  def product(*args)
    klass=[]
    if args[0].nil?
      "NIL"
    else
      klass=args[0].delete(:klass)
    end
    haml :product_table, {}, :klass => klass.join(" ")
  end

  def dame_haml(textohaml)
    Haml::Engine.new(textohaml).render    
  end
end
#end
