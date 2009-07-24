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
  
  def jquery_plugin(plugin)
    plugin=plugin+".js" unless plugin =~ /\.js$/
    js_tag "thirdparty/jquery/#{plugin}"
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
    "<script type=\"text/javascript\">#{text}</script>"
  end
end
