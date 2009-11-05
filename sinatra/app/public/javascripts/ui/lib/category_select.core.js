(function($) {
  var $category_select = $.category_select = function( settings ){
    //    $('body').tab_slider( settings );
  };
  
  $category_select.defaults = {//the defaults are public and can be overriden.
  };
  
  $.fn.category_select = function ( settings ) {
    settings = $.extend( {}, $category_select.defaults, settings );
    return this.each(function() {
	var self=this;
	var breadcrumb=["Inicio"];
	var render_breadcrumb= function() {
	  var $tpl= $(".breadcrumb").clone();
	  $ul=$("<ul></ul>");
	  for (var i=0; i<breadcrumb.length; i++) {
	    if (breadcrumb.length > 1 && i != 0)
	      $ul.append("<li>&nbsp;>&nbsp;</li>");
	    $ul.append($("<li></li>").html("<a>"+jQuery.trim(breadcrumb[i])+"</a>"));

	  }
	  return $ul;
	};

	var callback=function(e) {
	  $click= $(this);
	  $(self).find(".category a.selected").removeClass("selected");
	  $click.addClass("selected");
	  var id=$(this).find("a").attr("href");
	  var $category_list=$(self).find(".category-list");
	  $category_list.load("http://localhost:4567"+id+"/children .category", function(text) {
	      $(self).find(".category").bind("click", callback);
	      breadcrumb.push($click.find("a").html());
	      $(self).find(".breadcrumb").html(render_breadcrumb());
	    });
	  e.preventDefault();
	};
	
	$(self).find(".category").bind("click", callback);
      });
  }
 })(jQuery);

function category_select(selector, options) {
  $(selector).category_select(options);
}
