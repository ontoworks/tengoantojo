  /** 
   * @returns:
   * @author:
   * @version:
   * @requires:
   */
var Product = function(o) {
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
  this.items = o.items || [];
    // Query
  this.proxy = o.proxy;
    this.callback = o.callback;
};
augment(ProductList, List);
augment(ProductList, Query);
augment(ProductList, UI);
