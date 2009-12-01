function mi_tienda() {
  $("#sections-nav").hide();
  var $product_form= $("#product-form").edit_product({});
  $product_form.hide();
  
  $("#add-product-btn").click(function() {
      $product_form.show();
      $(".product-form-bg").slideDown("slow");
    });
  $product_form.bind("no", function() {
      $product_form.hide();
      $(".product-form-bg").slideUp("slow");
    });

}
