function mi_tienda(proxy) {
  $("#sections-nav").hide();
  var $product_form= $("#product-form").edit_product({});
  $product_form.hide();  

  $.fn.product_list= function(settings) {
    return this.each(function() {
	// repeated code from app.js
	var product_list_callback = function(data, list) {
	  list.empty();
	  var entries = data.feed.entry;
	  for (var i=0; i<entries.length; i++) {
	    var entry = entries[i];	
	    if (entry.g$item_type[0].$t=="products") {
	      var uuid = (entry.id.$t).match(/\d+$/)[0];
	      var product = new Product({
		id: uuid,
		    name: entry.title.$t,
		    description: entry.content.$t,
		    image_url:entry.g$image_link ? entry.g$image_link[0].$t : "/images/icons/box-label.png",
		    price:entry.g$price[0].$t});
	      list.add(product);
	    }
	  }
	  
	  // refactor this
	  list.render();
	};
	
	var product_list=new ProductList({id:"mi-tienda-product-list",
	      proxy:settings.proxy,
	      callback: product_list_callback,
	      page_size:8});
	//	product_list.query(google_query("macbook", 24));
	$(this).bind("query", function() {
       	    product_list.query(google_query("macbook", 24));
	  });
      });

  };
  
  var Items_Proxy = {
    uri: "/santiago/items"
  };
  register_proxy([Items_Proxy]);

  var $product_list = $("#mi-tienda-product-list").product_list({
    proxy:Items_Proxy
	});

  $product_form.bind("no", function() {
      $product_form.hide();
      $(".product-form-bg").slideUp("slow");
      $product_list.trigger("query");
    });

  // click bindings for icons-menu options
  $("#add-product-btn").click(function() {
      $product_form.show();
      $(".product-form-bg").slideDown("slow");
    });
  $("#my-products-btn").click(function() {
      $product_list.trigger("query");
    });
  



}
