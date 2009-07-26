helpers do
  include UIHelpers
  include AssetsHelpers

  def haml_times(tpl, times)
    (haml tpl.to_sym)*times
  end

  def mock_products(count)
    #render_haml("%div.product-overlay")+(product_table)*count
    product_list(count)
  end

  def product_list(count)
    list = ""
    count.times do |i|
      @id="product-"+i.to_s
      list << product_table
    end
    #(haml :product_overlay)+
    list
  end

  def dame_haml(textohaml)
    Haml::Engine.new(textohaml).render    
  end

  def product_show_container
    product_list+product_pagination
  end

  def product_overlay
    haml :product_overlay
  end

  def product_list_pages(pages)
    (haml :product_list_page)*pages
  end

  def product_overlay_fixedbox
    haml :product_overlay_fixedbox
  end
end
#end
