var ProductOverlay = function() {
  
};

  var show_product_overlay = function(e) {
    /* product overlay */
    jQuery(".product-overlay-bg").css({opacity:0.8});

    var product = jQuery(e.target).closest(".product");
    var product_overlay = product.closest(".product-list").children(".product-overlay");

    var product_overlay_bg = jQuery(".product-overlay-bg:first");

    product_overlay_bg.css({width:"0px"});
    product_overlay_bg.animate({ width:"475px" });
    
    jQuery(".product-image.selected").css({background:"#fff", opacity:1});
    jQuery(".product-image.selected").toggleClass("selected");
    product.find(".product-image").toggleClass("selected");
    product.find(".product-image").css({background:"#000", opacity:0.8});
    product.find(".product-image img").css({opacity:1});
    
    overlays=jQuery(".overlay-iconos-top, .product-overlay");
    overlays.show();
    jQuery(".cerrar").click(function(){
      overlays.hide();
      product_overlay_bg.hide();
      jQuery(".product-image.selected").css({background:"#fff", opacity:1});
    });

    // fill up overlay data from product data
    var brief = jQuery(".brief");
    var image_url = product.find(".product-image img").attr("src");
    brief.find(".nombre").html(product.find(".nombre").html());
    brief.find(".descripcion").html(product.find(".descripcion").html());
    brief.find("#product-image-list img").attr("src",image_url);
    brief.find(".galleria img:first").attr("src",image_url);

    $("#product-image-list").ImageOverlay({image_height:'120px',image_width:'120px'});

   // scrolling slider for comments
   var n=5;
     $("#product-overlay .comments-container").scrollTo(60*n,300);

    // full media component
    $("#media-full-expand").click(function() {

	$(".brief-product-media").css({position:"absolute", top:"22px", background:"#888", "z-index":4});

	$("#media-full").animate({height:"300px", width:"453px"} ,1000);
	  //.css({background:"#fff", color:"#000"})

	//alert("here");

	$("#product-image-list").hide();

	$("#media-full ul").galleria();



	/*var product_image_slideshow = new Image_Slideshow({
	  navigation:"#product-image-slideshow .thumb-list li",
	  target:"#product-image-slideshow"
	  });*/
	
      });

    $("#product-comments").jScrollPane();





  };
  
