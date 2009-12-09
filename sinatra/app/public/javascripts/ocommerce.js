  /** 
   * @returns:
   * @author:
   * @version:
   * @requires:
   */
var Product = function(o) {
  this.id = o.id;
  this.name = o.name;
  this.description = o.description;
  this.price = o.price;
  this.image_url = o.image_url;
};
augment(Product, UI);

/** 
 * @returns:
 * @author:
 * @version:
 * @requires:
 */
var ProductList = function(o) {
  this.id = o.id;
  // UI
  this.tpl = o.tpl;
  // List
  this.page_size = o.page_size;
  this.items = o.items || [];
  // Query
  this.proxy = o.proxy;
  this.callback = o.callback;
  // Call constructors in Mashups (bad practice??)
  this.initialize();

  this.jquery.bind("load", function() {
      $(this).block({message:"cargando ..."});
    }).bind("ready", function() {
      $(this).unblock();
    });
};
ProductList.prototype.render = function() {
  $("#"+this.id).find(".nombre").truncate({max_length: 50});
  $("#"+this.id).find(".descripcion").truncate({max_length: 90});
};
augment(ProductList, Paged_List);
augment(ProductList, Query);
augment(ProductList, UI);


jQuery(document).ready(function($) {  
  var layout = Conf.Product.tpl();
  Product.prototype.html = function() {
    layout=layout.clone();
    layout.attr("id", this.id);
    layout.find(".nombre").html(this.name);
    layout.find(".descripcion").html(this.description);
    layout.find(".product-image img").attr("src", this.image_url);
    layout.find(".precio").html(this.price);
    return layout;
  };

  $.fn.ProductList = function(options) {
    return this.each(function() {
      return new ProductList(this, options);
    });
  };
});
