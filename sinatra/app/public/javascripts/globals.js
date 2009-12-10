/** 
 * @returns:
 * @author:
 * @version:
 * @requires:
 */
var Conf = {};
var Reg= (function () {
    return {
      Product: {
        //uri: "http://www.google.com/base/feeds/snippets",
        uri:"/product.json",
        //uri:"/data/snippets.json",
	tpl: ".product:eq(0)"
      },
      ProductList: {
        tpl: ".product-list:first",
	page_size: 10,
        query_string: "q="
      }
    }
  })();
/** 
 * @returns:
 * @author:
 * @version:
 * @requires:
 */
var Marketplace;

jQuery(document).ready(function($){
  Conf = (function () {
    return {
      Product: {
        //uri: "http://www.google.com/base/feeds/snippets",
        uri:"/product.json",
	//uri:"/data/snippets.json",
	tpl: function() {
	  return $(".product:eq(0)").clone();
	}
      },
      ProductList: {
        tpl: jQuery(".product-list:first"),
	page_size: 10,
        query_string: "q="
      }

      /*      product_tpl: function() {
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
	}*/
    }
  })();
});
