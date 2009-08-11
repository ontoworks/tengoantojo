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
