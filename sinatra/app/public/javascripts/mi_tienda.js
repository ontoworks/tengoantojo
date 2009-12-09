
var Google_Base_Product_List= function() {
  var product_list_callback = function(data, list) {
    list.empty();
    var entries = data.feed.entry;
    if (!entries) return false;
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
    $this.find(".product-list-scroll").jScrollPane({dragMaxHeight:100});
  }
};
Google_Base_Product_List.render= function(data) {
};

augment(Google_Base_Product_List, Paged_List);
augment(Google_Base_Product_List, Query);

$.widget("product_list", {
  _init: function() {
      this._render= this.options.render;
      this._list= new this.options.list({
	proxy:options.proxy,
	page_size:options.page_size
	})
      var product_list= new Google_Base_Product_List({
	id:"",
	proxy:settings.proxy,
        page_size:8
      });
    },
  destroy: function() {
    },
  query: function() {
      this._list.query(google_query("colombia", 24));
     }
  });
$.extend($.ui.product_list, {
  getter: "",
  defaults: {
  }
      
  });


$.fn.product_list= function(settings) {
  return this.each(function() {
      var $this=$(this);
      var $product_list= $("#product-list").product_list;
      $product_list({list:Google_Base_Product_List});


    /*      var product_list=new ProductList({id:"mi-tienda-product-list",
	    proxy:settings.proxy,
	    callback: product_list_callback,
	    page_size:8});*/
      //	product_list.query(google_query("macbook", 24));
      $(this).bind("query", $product_list("query"));
    });
};

$.fn.mi_tienda= function() {
  $("#sections-nav").hide();
  var $product_form= $("#product-form").edit_product({});
  $product_form.hide();  
  
  var Items_Proxy = {
    uri: "/santiago/items"
  };
  register_proxy([Items_Proxy]);
  
  var $product_list = $("#mi-tienda-product-list").product_list({
    proxy:Items_Proxy
	});

  var $ui_product_list= $("#mi-tienda-product-list").;


  var collapse_product_form= function() {
    $(".product-form-bg").slideUp("slow");
    $product_form.hide();
  };
  var expand_product_form= function() {
    $(".product-form-bg").slideDown("slow");
    $product_form.show();
  };
  
  // when the user does not want to create a new
  // product, then collapse product-form and
  // load product-list
  $product_form.bind("no", function() {
      collapse_product_form();
      //      $product_list.trigger("query");
      $ui_product_list("query");
    });
  
  // when 'esc' pressed: collapse product form 
  // and clean it up
  $(window).keydown(function(e) {
      if (e.which == 27) {
	collapse_product_form();
	$product_form.trigger("initialize_product_form");
      }
    });
  
  // click bindings for icons-menu options
  $("#add-product-btn").click(function() {
      expand_product_form();
    });
  $("#my-products-btn").click(function() {
      //      $product_list.trigger("query");
      $ui_product_list.trigger("query");
    });

  var edit_product_form= function() {
    expand_product_form();
    $product_form.trigger("");
  };

  // when click on a product the show product-form
  // to edit selected product
  $ui_product_list.find(".product").die('click');
  $ui_product_list.find(".product").live('click', edit_product_form);

  return { product_list:$ui_product_list, product_form:$product_form, el:this  }
};

function mi_tienda() {
  var mitienda=$(".mi-tienda").mi_tienda();
  mitienda.product_list.trigger("query");
}
