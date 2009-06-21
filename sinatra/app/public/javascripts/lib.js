(function() {
    var SCROLL_VALUE = 367;

    //var tabView = new YAHOO.widget.TabView('tabs');

    //    var product_list = YAHOO.util.Selector.query('.product-list');

    var scrollFrom = 0;
    var scrollTo = 0;

    var recalculate_scroll = function(dir) {
      var scrolls = false;
      var scroll_attrs = {
	scroll: { to: [0, scrollTo] }
      };

      if (dir == 1) {
	  if (scrollTo/SCROLL_VALUE < 2) {
	    scrolls = true;
	  }
      } else if (dir == -1) {
	  if (scrollTo/SCROLL_VALUE > 0) {
	    scrolls = true;
	  }
      }

      if (scrolls) {
	scrollTo += SCROLL_VALUE*dir;
	scroll_attrs = {
	  scroll: { to: [0, scrollTo] }
	};	
	var scroll = new YAHOO.util.Scroll("product-list", scroll_attrs); 
	scroll.animate();
      }
    }

    YAHOO.util.Event.on('abajo', 'click', function() {
      recalculate_scroll(1);
    });

    YAHOO.util.Event.on('arriba', 'click', function() {
      recalculate_scroll(-1);
    });
})();

/* product overlay */
jQuery(document).ready(function($){
  //$("body").supersleight();
  //$("#png-image").supersleight();

  $(".product-overlay").css({opacity:0.8});
  $(".image-overlay").css({opacity:0.8});
  //$(".image-overlay-hole").css({opacity:0});
  $(".product").click(function(e) {
    product = $(e.target).closest(".product");
    image_overlay = product.children(".image-overlay");
    product_overlay = product.closest(".product-list").children(".product-overlay");

    product_overlay.css({width:"0px"});
    product_overlay.animate({ width:"475px" });
    
    $(".product-image.selected").css({background:"#fff", opacity:1});
    $(".product-image.selected").toggleClass("selected");
    product.find(".product-image").toggleClass("selected");
    product.find(".product-image").css({background:"#000", opacity:0.8});
    product.find("img").css({opacity:1});
    /*$(".image-overlay.selected").toggle();
    $(".image-overlay.selected").toggleClass("selected");
    image_overlay.toggle();
    image_overlay.toggleClass("selected");*/
    
    overlays=$(".overlay-iconos-top, .overlay-iconos-right, .overlay-iconos-bottom");
    overlays.show();
    $(".cerrar").click(function(){
      overlays.hide();
      product_overlay.hide();
      $(".product-image.selected").css({background:"#fff", opacity:1});
    });
  });

  // load from google?
  $.get("/search/mp3+player");

});


