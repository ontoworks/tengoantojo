var Google_Base_Product_List= function(o) {  
  this.id= o.id;
  // UI
  this.tpl = o.tpl;
  this.jquery= o.jquery;
  // List
  this.page_size= o.page_size;
  this.items= o.items || [];
  this.$pages_container= $("#"+this.id).find(".product-list-page");
  // Query
  this.proxy= o.proxy;
  this.callback= function(data, list) {
    list.empty();
    var entries = data.feed.entry;
    if (!entries) return false;
    for (var i=0; i<entries.length; i++) {
      var entry = entries[i];	
      if (entry.g$item_type[0].$t=="products") {
	var uuid = (entry.id.$t).match(/\d+$/)[0];
	var id= entry.g$id[0].$t;
	var product = new UI_Product({
    	      id: id, // g:id
	      uuid: uuid, // google base id
	      name: entry.title.$t,
	      description: entry.content.$t,
	      category: entry.g$product_type[0].$t,
	      condition: entry.g$condition[0].$t,
	      image_url:entry.g$image_link ? entry.g$image_link[0].$t : "/images/icons/box-label.png",
	      price:entry.g$price[0].$t});
	// TODO: take DOM operations to
        // the UI component
	list.add(product);
      }
    }
    // refactor this
    // TODO: take DOM operations to
    // the UI component
    //    list.render();
    o.jquery.find(".product-list-scroll").jScrollPane({dragMaxHeight:100});
    // Ugly hack to pixel-perfect the product-list's scroller
    var height= parseInt(o.jquery.find(".jScrollPaneContainer")
			 .css("height").match(/\d+/))+2;
    o.jquery.find(".jScrollPaneContainer").css("height",height);
  }
};
augment(Google_Base_Product_List, Paged_List);
augment(Google_Base_Product_List, Query);
augment(Google_Base_Product_List, UI);

(function($) {
var UI_Product_List= {
 _init: function() {
    this._list= new this.options.list({
      jquery:this.element,
	  id:this.element.attr("id"),
	  proxy:this.options.proxy,
	  page_size:this.options.page_size
	  });
    
  },
 items: function() {
    return this._list;
  },
 destroy: function() {
  }
};

$.widget("ui.product_list", UI_Product_List);

$.extend($.ui.product_list, {
  getter: "items",
  defaults: {
  }
  });
 })(jQuery);

$.fn.mi_tienda= function() {
  var Items_Proxy = {
    uri: "/santiago/items"
  };

  $("#sections-nav").hide();
  var $product_form= $("#product-form").edit_product({proxy:Items_Proxy});
  $product_form.hide();  
  

  register_proxy([Items_Proxy]);
  
  var $ui_product_list=$("#mi-tienda-product-list");
  $ui_product_list.product_list({
        proxy:Items_Proxy,
	list: Google_Base_Product_List,
	page_size: 24
	});

  $product_list= $ui_product_list.product_list("items");

  var collapse_product_form= function() {
    //    $(".product-form-bg").slideUp("slow");
    $product_form.trigger("initialize_product_form");
    $product_form.hide();
  };
  var expand_product_form= function() {
    if ($product_form.is(":visible"))
      collapse_product_form();
    if(arguments[0]=="edit") {
      $product_form.trigger("view", "edit");
    } else {
      $product_form.trigger("view", "new");
    }
    $product_form.fadeIn();
  };
  
  // when the user does not want to create a new
  // product, then collapse product-form and
  // load product-list
  $product_form.bind("no", function() {
      collapse_product_form();
      //      $product_list.trigger("query");
      $product_list.query(google_query("macbook", 24));
    });
  
  // when 'esc' pressed: collapse product form 
  // and clean it up
  $(window).keydown(function(e) {
      if (e.which == 27) {
	collapse_product_form();
      }
    });
  
  // click bindings for icons-menu options
  $("#add-product-btn").click(function() {
      expand_product_form();
    });
  $("#my-products-btn").click(function() {
      $product_list.query(google_query("", 24));
    });

  // when click on a product the show product-form
  // to edit selected product
  var edit_product_form= function(e) {
    expand_product_form("edit");
    var $product= $(e.target).closest(".product");
    var _product= $product_list.get($product.attr("id"));
    $product_form.trigger("set_field", _product);
  };
  $ui_product_list.find(".product").die('click');
  $ui_product_list.find(".product").live('click', edit_product_form);

  return { product_list:$product_list, product_form:$product_form, el:this  };
};

function mi_tienda() {
  var mitienda=$(".mi-tienda").mi_tienda();
  mitienda.product_list.query(google_query("", 24));
}
