  var show_product_overlay = function(e) {
    /* product overlay */
    jQuery(".product-overlay").css({opacity:0.8});
    jQuery(".image-overlay").css({opacity:0.8});

    product = jQuery(e.target).closest(".product");
    image_overlay = product.children(".image-overlay");
    product_overlay = product.closest(".product-list").children(".product-overlay");

    product_overlay.css({width:"0px"});
    product_overlay.animate({ width:"475px" });
    
    jQuery(".product-image.selected").css({background:"#fff", opacity:1});
    jQuery(".product-image.selected").toggleClass("selected");
    product.find(".product-image").toggleClass("selected");
    product.find(".product-image").css({background:"#000", opacity:0.8});
    product.find("img").css({opacity:1});
    /*$(".image-overlay.selected").toggle();
    $(".image-overlay.selected").toggleClass("selected");
    image_overlay.toggle();
    image_overlay.toggleClass("selected");*/
    
    overlays=jQuery(".overlay-iconos-top, .overlay-brief, .overlay-comentarios, .overlay-iconos-bottom");
    overlays.show();
    jQuery(".cerrar").click(function(){
      overlays.hide();
      product_overlay.hide();
      jQuery(".product-image.selected").css({background:"#fff", opacity:1});
    });
  };
  
