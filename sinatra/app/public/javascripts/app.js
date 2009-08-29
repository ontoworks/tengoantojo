jQuery(document).ready(function($) {
  //register Proxies
  var ProductProxy = {
    uri: Conf.Product.uri
  };
  register_proxy([ProductProxy]);

  marketplace = function() {
    var default_nav = new UI({id:"tab-ul"});

    var inicio_view = function() {
      var search = new UI({id:"tab-ul"});
      var bridge_control = new UI();
      var product_overlay = new Product_Overlay({id:"product-overlay"});

      var product_list_callback = function(data, list) {
	var entries = data.feed.entry;
      
	for (var i=0; i<entries.length; i++) {
	  var entry = entries[i];	
	  //if (entry.g$item_type[0].$t=="Products") {
	  var product = new Product({
	    id: entry.id.$t,
		name: entry.title.$t,
		description: entry.content.$t,
		image_url:entry.g$image_link ? entry.g$image_link[0].$t : "",
		price:entry.g$price[0].$t});
	  
	  $("#inicio .product").click(product_overlay.show);
	  list.add(product);
	  //}
	}
	list.render();
      }

      var product_list = new ProductList({id:"product-list-0",
	    proxy:ProductProxy,
	    tpl:Conf.ProductList.tpl,
	    callback: product_list_callback,
	    page_size:8});
      product_list.query(google_query("macbook", 24));

      this.id="inicio";
      this.items=[search, bridge_control, product_list, product_overlay];
    };

    var favoritos_view = function() {
    };

    var mitienda_view = function() {
    };

    var promociones_view = function() {
    };

    inicio_view();
    left_slider();
  };
});

function social() {
  right_slider();
}

function geocity() {
}

function events() {
}

function room() {
}

function global_nav() {
}

jQuery(document).ready(function($) {
  jQuery('#search').keyup(function(e) {
    if(e.keyCode == 13) {
      var query = jQuery('#search').val();
      query=google_query(query, 30);
      product_list_0.query(query);
    }
  });
   
   // global-nav navigation
  var global_nav = new Ajax_Slideshow({
    target:"#main",
    navigation:"#global-nav a"
  });
  marketplace();
}); //ends
