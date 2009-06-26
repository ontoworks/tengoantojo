/** 
 * @returns:
 * @author:
 * @version:
 * @requires:
 */
var product_table = function(opts) {
  var price = opts.price;
  var title = opts.title;
  var description = opts.description;
  var image_url = opts.image_url;
  var gb_id = opts.gb_id;
  var tpl = Conf.product_tpl();

  tpl.attr("id", gb_id);
  tpl.find(".nombre").html(title);
  tpl.find(".descripcion").html(description);
  tpl.find(".product-image img").attr("src",image_url);
  tpl.find(".precio").html(price);

  return tpl;
};

/** 
 * @returns:
 * @author:
 * @version:
 * @requires:
 */
function json_from_gb(root) {
  //alert("json_from_gb");
  var feed = root.feed;
  var entries = feed.entry || [];

  var product_list_tpl=jQuery("#inicio .product-list");
  
  for (var i = 0; i < entries.length; ++i) {
    var current_page = Math.floor(i/10);
    var product_list_page_tpl;
    if (i%10 == 0) {
      product_list_page_tpl = product_list_tpl.find("#page-"+current_page);
      product_list_page_tpl.empty();
    }
    
    var entry = entries[i];

    if (entry.g$item_type[0].$t=="Products") {
      var gb_id = entry.id.$t;

      var title = entry.title.$t;
      var description = entry.content.$t;
      var image_uri = entry.g$image_link ? entry.g$image_link[0].$t : "";
      var price = entry.g$price[0].$t;
      
      pt=new product_table({
          price:price,
          title:title,
          description:description,
          image_url:image_uri
        });
      pt.click(show_product_overlay);
      product_list_page_tpl.append(pt.attr("id", i));
    }
  }
  feed, entries = undefined;
  $(".nombre").truncate({max_length: 50});
  $(".descripcion").truncate({max_length: 100});

}
