

#
# module contains helpers for producing UI
# components
#
module UI
  # dynamically guess what helpers have been called
  # by creating accessor methods at runtime
  class Assets
    def initialize
      # instance variables are pushed to iv_array when
      # their respective writers are called
      @iv_array = []

      AssetsHelpers.instance_methods.each do |meth|
        self.class.send(:attr_reader, meth)
        iv_writer = lambda { |x|
          @iv_array = @iv_array | [meth]
          instance_variable_set("@#{meth}", x)
        }
        self.class.send(:define_method, "#{meth}=", iv_writer)
      end
    end

    # returns helpers that've been called only.
    def helpers
      @iv_array
    end
  end

  # generates head tag using HAML
  def haml_head(title, assets)
    head = ""
    head << "%head\n"
    head << "  %title #{title}\n"
    head << "  %meta{\"http-equiv\"=>\"Content-Type\", :content=>\"text/html;charset=utf-8\"}"
    assets.helpers.each do |lib|
      lib.gsub!(/@/, "")
      puts lib
      assets.send(lib).each {|path| head << "  =#{lib} \"#{path}\"\n"}
    end
    haml head
  end

  # generates head tag directly in HTML
  def head_generator(title, assets)
    head = ""
    head << "<head>\n"
    head << "  <meta http-equiv=\"Content-Type\" content=\"text/html;charset=utf-8\"/>"
    head << "  <title>#{title}</title>\n"
    assets.helpers.each do |lib|
      lib.gsub!(/@/, "")
      assets.send(lib).each {|path| head << "  #{send(lib, path)}\n"}
    end
    head << "</head>"
    head
  end

  # when GET /design/categorias_nav
  # this function describes the assets (JS and CSS) necessary
  # to show 'categorias_nav' component as an isolated
  # fully-functional application.
  def categorias_nav
    assets= Assets.new
    assets.lib = ["jquery"]
    assets.jquery_plugin = ["scrollto/1.4.1/jquery.scrollTo-min",
                            "localscroll/1.2.7/jquery.localscroll-min",
                            "codalike-slider/jquery.serialScroll-1.2.1"]
    assets.js_tag = ["categorias_scroller"]
    assets.css_link = ["/javascripts/thirdparty/yui/build/fonts/fonts-min.css",
                       "style"]
    assets.script = "categorias_scroller()"
    assets
  end

  # GET /design/tab_slider
  def tab_slider
    assets= Assets.new
    assets.lib = ["jquery"]
    assets.jquery_plugin = ["scrollto/1.4.1/jquery.scrollTo-min",
                            "localscroll/1.2.7/jquery.localscroll-min",
                            "codalike-slider/jquery.serialScroll-1.2.1"]
    assets.js_tag = ["tab_slider"]
    assets.css_link = ["/javascripts/thirdparty/yui/build/fonts/fonts-min.css",
                       "style"]
    assets.script = "tab_slider()"
    assets
  end

  # GET /design/category_select
  def category_select
    assets= Assets.new
    assets.lib = ["ie8","jquery"]
    assets.js_tag = ["ui/lib/category_select.core"]
    assets.css_link = ["/javascripts/thirdparty/yui/build/fonts/fonts-min.css",
                       "styles"]
    assets.script = "category_select('.category-select', {})"
  
    json={}
    if @id
      json=RestClient.get couchdb_doc_url(:categories, @id)
      puts json
    else
      json=RestClient.get couchdb_view_url(:categories,:tree,:root)
    end
    list=JSON.parse json
    [assets, {:category_list=>list["rows"], :id=>@id}]
  end

  def user
    assets= Assets.new
    assets.lib = ["jquery"]
    assets.jquery_plugin = ["form/jquery.form"]
    assets.js_tag = ["user"]
    assets.css_link = ["user"]
    assets
  end

  # GET /design/mi_tienda
  # contains: product_form
  def mi_tienda
    assets= Assets.new
    assets.lib = ["jquery"]
    assets.jquery_plugin = ["ui/ui.core","jScrollPane/jScrollPane","blockUI/jquery.blockUI","jeip/jeip","truncator/truncator","mousewheel/jquery.mousewheel"]
    assets.js_tag = ["globals","lib","ocommerce","ui/lib/category_select.core","product_form","mi_tienda"]
#    assets.js_tag << "http://getfirebug.com/releases/lite/1.2/firebug-lite-compressed"
    assets.css_link = ["/javascripts/thirdparty/yui/build/fonts/fonts-min.css",
                       "corner-radius",
                       "jScrollPane",
                       "styles"]
    assets.script = "mi_tienda();"
    [assets, {:product_form=>{:id=>"product-form"}}]
  end

  def product_form()
    assets= Assets.new
    assets.lib = ["jquery"]
    assets.jquery_plugin = ["blockUI/jquery.blockUI","jeip/jeip"]
    assets.js_tag = ["lib","ui/lib/category_select.core","product_form"]
    assets.css_link = ["/javascripts/thirdparty/yui/build/fonts/fonts-min.css",
                       "corner-radius",
                       "styles"]
    assets.script = "product_form()"
    [assets, {:id=>"product-form"}]
  end

  # GET /design/marketplace
  def marketplace
    assets= Assets.new
    assets.lib = ["jquery"]
    assets.jquery_plugin = ["scrollto/1.4.1/jquery.scrollTo-min",
                            "localscroll/1.2.7/jquery.localscroll-min",
                            "codalike-slider/jquery.serialScroll-1.2.1",
                            "codalike-slider/coda-slider"]
    assets.css_link = ["/javascripts/thirdparty/yui/build/fonts/fonts-min.css",
                       "styles",
                       "codaslider"]
    assets.script = "left_slider()"
    assets
  end

  def marketplace_home
    assets= Assets.new
    assets.lib = ["jquery"]
    assets.jquery_plugin = ["scrollto/1.4.1/jquery.scrollTo-min",
                            "localscroll/1.2.7/jquery.localscroll-min",
                            "codalike-slider/jquery.serialScroll-1.2.1"]
    assets.css_link = ["/javascripts/thirdparty/yui/build/fonts/fonts-min.css",
                       "styles"]
    assets.js_tag = ["tab_slider","marketplace_home"]
    assets.script="marketplace_home()"
    assets
  end

  # GET /design/social
  def social
    assets= Assets.new
    assets.lib = ["jquery"]
    assets.jquery_plugin = ["scrollto/1.4.1/jquery.scrollTo-min",
                            "localscroll/1.2.7/jquery.localscroll-min",
                            "codalike-slider/jquery.serialScroll-1.2.1"]
    assets.js_tag = ["tab_slider"]
    assets.css_link = ["/javascripts/thirdparty/yui/build/fonts/fonts-min.css",
                       "styles"]
    assets.script = "right_slider()"
    assets
  end

  # GET /design/perfil
  def perfil
    assets= Assets.new
    assets.lib = ["jquery"]
    assets.jquery_plugin = ["jeip/jeip",
                           "autocomplete/jquery.autocomplete"]
    assets.js_tag = ["http://maps.google.com/maps/api/js?sensor=false","perfil"]
    assets.css_link = ["/javascripts/thirdparty/yui/build/fonts/fonts-min.css",
                       "style",
                       "jquery.autocomplete",
                       "jquery-ui-1.7.2"]
    assets
  end

  def product_list
    assets= Assets.new
    assets.lib = ["jquery"]
    assets.jquery_plugin = ["scrollto/1.4.1/jquery.scrollTo-min",
                            "localscroll/1.2.7/jquery.localscroll-min",
                            "codalike-slider/jquery.serialScroll-1.2.1"]
    assets.js_tag = ["tab_slider"]
    assets.css_link = ["/javascripts/thirdparty/yui/build/fonts/fonts-min.css",
                       "styles"]
    assets.script = "my()"
    assets
  end

module DesignHelpers
  
  #
  # given some assets and a component's tpl
  # render the component as a standalone web page 
  # => 
  def design(tpl)
    assets,locals = send(tpl)
    @head = head_generator tpl, assets
    @component = haml tpl.to_sym, :locals =>locals
    haml :standalone
  end
  
  # => 
  # alias for design so far, but'll perform its own stuff
  # => 
  def embed(tpl)
    design(tpl)
  end
  
  # => 
  # generic navigation component
  # => 
  def navigation(id, clas, names)
    @id=id
    @class=clas
    @names=names
    haml :navigation
  end
end
end
# delivers a single UI component as an isolated
# fully-functional standalone application
get '/design/:component' do
  design params[:component]
end

# delivers component's HTML
get '/ui/:component' do
  assets,locals = send(params[:component])
  haml params[:component].to_sym, :locals => locals
end
