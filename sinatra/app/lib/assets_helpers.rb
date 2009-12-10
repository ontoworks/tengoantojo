module AssetsHelpers
  def self.each 
    instance_methods.each do |method|
      yield method
    end
  end

  def ie8
    <<IE8
<!--[if lte IE 7]>
 <script src="/javascripts/thirdparty/ie7/IE8.js" type="text/javascript"></script>
 <script src="/javascripts/thirdparty/ie7/ie7-squish.js" type="text/javascript"></script>
<![endif]-->
IE8
  end

  def img(uri, ops={})
    id=ops.delete(:id)
    dame_haml("%img#{id.nil? ? "" : "#"+id}{:src=>'#{uri}'}")
  end
  
  def style
    header 'Content-Type' => 'text/css; charset=utf-8'
    sass :style
  end

  def css_link(file)
    if file.index("/")==0
      href=file
    else
      href="/stylesheets/#{file}"
    end
    href=href+".css" unless file =~ /\.css$/
    haml "%link{:rel => 'stylesheet', :type => 'text/css', :media => 'screen', :href => '#{href}'}"
  end
    
  def grid_js_css
    js_tag "thirdparty/960grids/javascripts/grid.js"
    css_link "/javascripts/thirdparty/960grids/stylesheets/grid.css"
    css_link "/javascripts/thirdparty/960grids/grids/grid"
  end
  
  def js_tag(path)
    file="/javascripts/" << path
    file << ".js" unless file =~ /\.js$/
    file=path if path =~ /^http/
    "<script src=\"#{file}\" type=\"text/javascript\"></script>"
  end
  
  def jspec_ui(lib)
    js_tag "ui/lib/#{lib}"
  end
 
  def yui(lib)
    js_tag "thirdparty/yui/build/#{lib}"
  end
  
  def jquery
    js_tag "thirdparty/jquery/jquery-1.3"
  end
  
  def jquery_min
    js_tag "thirdparty/jquery/jquery-1.3.min"
  end

  def jquery_plugin(plugin)
    plugin=plugin+".js" unless plugin =~ /\.js$/
    js_tag "thirdparty/jquery/#{plugin}"
  end  

  def jquery_ui(widget=false)
    if widget
      jquery_plugin "jquery-ui-1.7.2/development-bundle/ui/ui."+widget
    else
      jquery_plugin "ui/ui.core"
    end
  end

#
# calls the helper method for a javascript lib VS(:jquery, :yui ...)
#
  def lib(lib)
    send(lib)
  end

#
# encloses a text within a javascript script tag
#
  def script(text)
    "<script type=\"text/javascript\">jQuery(document).ready(function() {#{text};});</script>"
  end
end
