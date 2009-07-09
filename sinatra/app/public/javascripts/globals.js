/** 
 * @returns:
 * @author:
 * @version:
 * @requires:
 */
var Conf = {};
jQuery(document).ready(function($){
    // initial load from google
  /*jQuery.getScript("http://www.google.com/base/feeds/snippets?q=macbook&alt=json-in-script&callback=json_from_gb&max-results=30");*/

  myserialscroller();
  coda_slider();

  Conf = (function () {
    return {
      Product: {
        //uri: "http://www.google.com/base/snippets",
        //uri:"/product",
        uri:"/data/snippets.json",
	tpl: function() {
	  return $(".product:first").clone();
	 }
      },
      ProductList: {
        tpl: jQuery(".product-list:first"),
	page_size: 10,
        query_string: "q="
      },

      product_tpl: function() {
        a = jQuery(".product:first");
        return a.clone();
      },

      product_list_page_tpl: function() {
        a = jQuery(".product-list-page:first");
        return a.clone();
      },

      product_list_tpl: function() {
        a = jQuery(".product-list:first");
        return a.clone();
      }
    }
  })();

  /*  jQuery('#search').keyup(function(e) {
    if(e.keyCode == 13) {
      var query = jQuery('#search').val();
      var url = "http://www.google.com/base/feeds/snippets?q="+query+"&alt=json-in-script&callback=json_from_gb&max-results=30"
      jQuery.getScript(url);
    }
    });*/
});
