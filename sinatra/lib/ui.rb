# dynamically guess what helpers have been called
# by creating accessor methods in runtime
class Assets
  def initialize
    # instance variables are pushed to iv_array when
    # their respectives writers are called
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

module UIHelpers
  def c(component)
    haml component.to_sym
  end

  def haml_head(title, assets)
    head = ""
    head << "%head\n"
    head << "  %title #{title}\n"
    assets.helpers.each do |lib|
      lib.gsub!(/@/, "")
      puts lib
      assets.send(lib).each {|path| head << "  =#{lib} \"#{path}\"\n"}
    end
    haml head
  end

  def head_generator(title, assets)
    head = ""
    head << "<head>\n"
    head << "  <title>#{title}</title>\n"
    assets.helpers.each do |lib|
      lib.gsub!(/@/, "")
      assets.send(lib).each {|path| head << "  #{send(lib, path)}\n"}
    end
    head << "</head>"
    head
  end

  def home
    haml :home
  end

  def head
    haml :head
  end

  def content
    haml :body1
  end

  def product_table
    haml :product_table
  end

  def product_list_home
    haml :product_list
  end

  def categorias_nav
    assets= Assets.new
    assets.lib = ["jquery"]
    assets.jquery_plugin = ["scrollto/1.4.1/jquery.scrollTo-min",
                            "localscroll/1.2.7/jquery.localscroll-min",
                            "codalike-slider/jquery.serialScroll-1.2.1"]
    assets.js_tag = ["categorias_scroller"]
    assets.css_link = ["/javascripts/thirdparty/yui/build/fonts/fonts-min.css",
                       "style"]
    assets.script = "jQuery(document).ready(function() {categorias_scroller();})"
    assets
  end

  def left
    assets= Assets.new
    assets.lib = ["jquery"]
    assets.jquery_plugin = ["scrollto/1.4.1/jquery.scrollTo-min",
                            "localscroll/1.2.7/jquery.localscroll-min",
                            "codalike-slider/jquery.serialScroll-1.2.1",
                            "codalike-slider/coda-slider"]
    assets.css_link = ["/javascripts/thirdparty/yui/build/fonts/fonts-min.css",
                       "style",
                       "codaslider"]
    assets.script = "jQuery(document).ready(function() {left_slider();})"
    assets
  end

  def right
    assets= Assets.new
    assets.lib = ["jquery"]
    assets.jquery_plugin = ["scrollto/1.4.1/jquery.scrollTo-min",
                            "localscroll/1.2.7/jquery.localscroll-min",
                            "codalike-slider/jquery.serialScroll-1.2.1"]
    assets.js_tag = ["tab_slider"]
    assets.css_link = ["/javascripts/thirdparty/yui/build/fonts/fonts-min.css",
                       "style"]
    assets.script = "jQuery(document).ready(function() {right_slider();})"
    assets
  end

#
# given some assets and a component's tpl
# render the component as a standalone page
#
  def standalone(tpl)
    assets = send(tpl)
    @head = head_generator tpl, assets
    @body = haml tpl.to_sym
    haml :standalone
  end
end

get '/design/:component' do
  standalone params[:component]
end

get '/ui/:component' do
  haml params[:component].to_sym
end
