#module UIHelper
  def head
    haml :head
  end

  def scripts
    <<SCRIPT
<script>
(function() {
    var tabView = new YAHOO.widget.TabView('tabs');

    var attributes = {
        scroll: { to: [0, 500] }
    };
    var product_list = YAHOO.util.Selector.query('.product-list');
    var anim = new YAHOO.util.Scroll("product-list", attributes);
    YAHOO.util.Event.on('abajo', 'click', function() {
        anim.animate();
    });

    YAHOO.log("The example has finished loading; as you interact with it, you'll see log messages appearing here.", "info", "example");
})();
</script>
SCRIPT
  end


  #def content
  #  haml :body
  #end
  def img(uri, ops={})
    id=ops.delete(:id)
    dame_haml("%img#{id.nil? ? "" : "#"+id}{:src=>'#{uri}'}")
  end

  def css_link(file)
    if file.index("/")==0
      href=file
    else
      href="/stylesheets/#{file}"
    end
    href=href+".css" unless file =~ /\.css$/
    haml "%link{:rel => 'stylesheet', :type => 'text/css', :media => 'screen', :href => '#{href}'}"
#    "<link href=\"/stylesheets/#{file}\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />"
  end

  def grid_js_css
    js_tag "thirdparty/960grids/javascripts/grid.js"
    css_link "/javascripts/thirdparty/960grids/stylesheets/grid.css"
    css_link "/javascripts/thirdparty/960grids/grids/grid"
  end

  def js_tag(file)
    file=file+".js" unless file =~ /\.js$/
    "<script src=\"/javascripts/#{file}\" type=\"text/javascript\"></script>"
  end

  def yui(lib)
    js_tag "thirdparty/yui/build/#{lib}"
  end

  def jquery
    js_tag "thirdparty/jquery/jquery-1.3"
  end

  def product
    (haml :product)+
    (haml :product)
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
    (haml :product_overlay)+
    list
  end

  def dame_haml(textohaml)
    Haml::Engine.new(textohaml).render    
  end

  #def product_list
  #  list=list+product
  #end

  def product_pagination
  end

  def product_show_container
    product_list+product_pagination
  end

  def categorias_nav
    haml :categorias_nav
  end

  def product_overlay
    haml :product_overlay
  end

  def product_overlay_fixedbox
    haml :product_overlay_fixedbox
  end

#end

