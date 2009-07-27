jQuery(document).ready(function($) {
  /** 
   * @returns:
   * @author:
   * @version:
   * @requires:
   */
  var ProductProxy = {
    uri: Conf.Product.uri
  };
  augment(ProductProxy, Resource);

  Product.prototype.html = function() {
    this.tpl = Conf.Product.tpl();
    this.tpl.attr("id", this.id);
    this.tpl.find(".nombre").html(this.name);
    this.tpl.find(".descripcion").html(this.description);
    this.tpl.find(".product-image img").attr("src", this.image_url);
    this.tpl.find(".precio").html(this.price);
    return this.tpl;
  };

  // load all product lists
  function product_list_callback (data, list) {
    var page_size = Conf.ProductList.page_size;
    var feed = data.feed;
    var entries = feed.entry;

    var product_count = 0;
    var product_list_page_tpl;
    var new_page = false;
    for (var i=0; i<entries.length; i++) {
      var entry = entries[i];
      if (entry.g$item_type[0].$t=="Products") {
	new_page = product_count%page_size == 0 ? true : false;
	if (new_page) {
	  var page = Math.floor(product_count/page_size);
	  product_list_page_tpl = $(list.tpl.find(".product-list-page")[page]);
	  product_list_page_tpl.empty();
	}

	var product = new Product({
	  id: entry.id.$t,
	  name: entry.title.$t,
	  description: entry.content.$t,
	  image_url:entry.g$image_link ? entry.g$image_link[0].$t : "",
	  price:entry.g$price[0].$t});

	list.add(product);
	product_list_page_tpl.append(product.html().click(show_product_overlay));

	product_count++;
      }
    }
    $(".nombre").truncate({max_length: 50});
    $(".descripcion").truncate({max_length: 100});
  };

  function google_query(q, max_results) {
    var alt="json";
    var query="?q="+q+"&alt="+alt+"&max-results="+max_results;
    return query;
    }
  var product_list_query = "?q=macbook&alt=json&max-results=30";
  var product_list_0 = new ProductList({id:"product-list-0",
	proxy:ProductProxy,
	tpl:Conf.ProductList.tpl,
	callback: product_list_callback});
  product_list_0.query(google_query("macbook", 30));

  // product overlay
  // event: when btn "meantoje" clicked slide #montaje-overlay
  $(".meantoje a").click(function() {
      $(this).css({
	background:"#ccc",
	color:"#000"
	});
      $(".meantoje").css({
	background:"#ccc",
	color:"#000"
	});
      $("#meantoje-overlay").slideToggle();
    });

   jQuery('#search').keyup(function(e) {
      if(e.keyCode == 13) {
	var query = jQuery('#search').val();
	query=google_query(query, 30);
	product_list_0.query(query);
      }
      });
  
   var last_x=0;
   // slider for scrolling comments
   $("#slider-vertical").slider({
     orientation: "vertical",
	 range: "min",
	 min: 0,
	 max: 540,
	 value: 540,
	 slide: function(event, ui) {
	 //	   $("#amount").val(ui.value);
	 //
	 var x=540-ui.value;
	 var dir=1;
	 if (Math.abs(x-last_x)>6) {
	   $("#murmullo .comments-container").scrollTo(x,540);
	   //alert(x-last_x);
	 }
	 last_x=x;
       }
     });
   //   $("#amount").val($("#slider-vertical").slider("value"));



});

