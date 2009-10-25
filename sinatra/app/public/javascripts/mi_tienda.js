(function($) {
  $mi_tienda = $.mi_tienda = function(settings) {
  };

  $.fn.mi_tienda = function(settings) {
    settings = $.extend( {}, $mi_tienda.defaults, settings );
    //    $(this).find(".product_form").product_form();
  };
 })(jQuery);
