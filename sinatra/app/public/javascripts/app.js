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
	list.empty();
	var entries = data.feed.entry;
	for (var i=0; i<entries.length; i++) {
	  var entry = entries[i];	
	  if (entry.g$item_type[0].$t=="Products") {
	    var uuid = (entry.id.$t).match(/\d+$/)[0];
	    var product = new Product({
	      id: uuid,
	      name: entry.title.$t,
	      description: entry.content.$t,
		image_url:entry.g$image_link ? entry.g$image_link[0].$t : "",
		price:entry.g$price[0].$t});
	  
	    list.add(product);
	  }
	}

	// refactor this
	list.render();
      };

      var product_list = new ProductList({id:"product-list-0",
	    proxy:ProductProxy,
	    tpl:Conf.ProductList.tpl,
	    callback: product_list_callback,
	    page_size:8});
      product_list.query(google_query("macbook", 24));

      this.id="inicio";
      this.items=[search, bridge_control, product_list, product_overlay];

      jQuery('#srch_fld').keyup(function(e) {
        if(e.keyCode == 13) {
          var query = $(this).val();
          product_list.query(google_query(query, 24));
        }
      });
    };

    var favoritos_view = function() {
    };

    var mitienda_view = function() {
      $("#add-product-btn").click(function() {
	  $(".product-form").edit_product({});
	});
    };

    var promociones_view = function() {
    };

    // initialize slides
    inicio_view();
    mitienda_view();

    // should not go here
    left_slider();
  };
});

function social() {
  $("#right-tabs")
    .tab_slider({
      panels: $('#right-tabs .right-scrollContainer > div'),
	  scroll: $('#right-tabs .right-scroll').css('overflow', 'hidden'),
	  container: $('#right-tabs .right-scrollContainer')
	  });
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
   // global-nav navigation
  var global_nav = new Ajax_Slideshow({
    target:"#main",
    navigation:"#global-nav a"
  });
  $("#main").bind("load", function() {
      $(this).block({message:"cargando ..."});
    }).bind("ready", function() {
      $(this).unblock();
    });


  marketplace();

  var as_favorite = function(e) {
    var image_on = "/images/corazon-solido-icon-2.png";
    var image_off = "/images/corazon-icon.png";
    var product = jQuery(e.target).closest(".product");
    var as_favorite = product.find(".as-favorite");
    var url="http://172.16.77.1:4567/favoritos/"+product.attr("id");
    
    as_favorite.toggleClass("on");
    if (as_favorite.hasClass("on")) {
      product.find(".as-favorite img").attr("src", image_on);
      var data=$.toJSON({"user":1});
      $.ajax({
	url:url,
	  dataType:"json",
	  contentType:"application/json",
	  data:data,
	  type:'PUT',
	  complete:function(data) {
	    //	    alert(data);
	  }
      });
    } else {
      product.find(".as-favorite img").attr("src", image_off);
      $.ajax({
	url:url,
	  dataType:"json",
	  contentType:"application/json",
	  data:data,
	  type:'DELETE',
	  complete:function(data) {
	    //	    alert(data);
	  }
      });
    }
  };

  var product_overlay = new Product_Overlay({id:"product-overlay"});
  // live events
  $("#inicio .product-image").live('click', product_overlay.show);
  $("#inicio .as-favorite").live('click', as_favorite);
}); //ends
