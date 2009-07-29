var ProductOverlay = function() {
  
};

  var show_product_overlay = function(e) {
    /* product overlay */
    jQuery(".product-overlay-bg").css({opacity:0.8});
    jQuery(".image-overlay").css({opacity:0.8});

    var product = jQuery(e.target).closest(".product");
    var image_overlay = product.children(".image-overlay");
    var product_overlay = product.closest(".product-list").children(".product-overlay");

    var product_overlay_bg = jQuery(".product-overlay-bg:first");

    product_overlay_bg.css({width:"0px"});
    product_overlay_bg.animate({ width:"475px" });
    
    jQuery(".product-image.selected").css({background:"#fff", opacity:1});
    jQuery(".product-image.selected").toggleClass("selected");
    product.find(".product-image").toggleClass("selected");
    product.find(".product-image").css({background:"#000", opacity:0.8});
    product.find("img").css({opacity:1});
    
    overlays=jQuery(".overlay-iconos-top, .product-overlay");
    overlays.show();
    jQuery(".cerrar").click(function(){
      overlays.hide();
      product_overlay_bg.hide();
      jQuery(".product-image.selected").css({background:"#fff", opacity:1});
    });

    var brief = jQuery(".brief");
    brief.find(".nombre").html(product.find(".nombre").html());
    brief.find(".descripcion").html(product.find(".descripcion").html());

   var n=5;
     $("#product-overlay .comments-container").scrollTo(60*n,300);

  };
  
