  /** 
   * @returns:
   * @author:
   * @version:
   * @requires:
   */
var Product = function(o) {
  this.id= o.id;
  this.uuid= o.uuid;
  this.name= o.name;
  this.description= o.description;
  this.price= o.price;
  this.condition= o.condition;
  this.category= o.category;
  this.image_url= o.image_url;
};


/** 
 * @returns:
 * @author:
 * @version:
 * @requires:
 */
var UI_Product= function(o) {
  this._o=new Product(o);
  this._$layout= $(Reg.Product.tpl).clone();
};
UI_Product.prototype.render= function() {
  this._$layout.attr("id", this.attr("id"));
  this._$layout.find(".nombre").html(this.attr("name"));
  this._$layout.find(".descripcion").html(this.attr("description"));
  this._$layout.find(".product-image img").attr("src", this.attr("image_url"));
  this._$layout.find(".precio").html(this.attr("price"));
  return this._$layout;
};
UI_Product.prototype.attr= function(label) {
  if (!label.match(/^_.*$/))
    return this._o[label];
  else
    // should raise exception:
    // trying to access private member
    return false;
};
UI_Product.prototype.product= function() {
  return this._o;
};
augment(UI_Product, UI);

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
  /** 
   * @returns:
   * @author:
   * @version:
   * @requires:
   */
  UI_Product.prototype.html = function() {
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
