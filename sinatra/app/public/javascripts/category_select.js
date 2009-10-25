(function($) {
  var $category_select = $.category_select = function( settings ){
    //    $('body').tab_slider( settings );
  };

  $category_select.defaults = {//the defaults are public and can be overriden.
  };

  $.fn.category_select = function ( settings ) {
    settings = $.extend( {}, $category_select.defaults, settings );
    return this.each(function() {
      });
  }
})(jQuery);

function category_select(selector, options) {
    $(selector).category_select(options);
}
