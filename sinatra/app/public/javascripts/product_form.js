(function($) {
  var $edit_product = $.edit_product = function( settings ){
    //    $('body').tab_slider( settings );
  };

  $edit_product.defaults = {//the defaults are public and can be overriden.
    width:526,
    background:".product-form-bg"
  };


  $.fn.edit_product = function ( settings ) {
    settings = $.extend( {}, $edit_product.defaults, settings );
    // form_data as instance variable so it may be
    // seen from JSpec
    this.form_data={};
    $this=this;
    return this.each(function() {
	var eip_options = 
	  {
	  savebutton_text: "ok",
	  cancelbutton_text: "x",
	  form_buttons: '<span><input type="button" id="save-#{id}" class="#{savebutton_class}" value="#{savebutton_text}" /> <input type="button" id="cancel-#{id}" class="#{cancelbutton_class}" value="#{cancelbutton_text}" /></span>',
	  ok: function(el) {
	      // el.id contains something like 'product-name'
	      $this.form_data[el.id.split("-")[0]+"["+el.id.split("-")[1]+"]"] = $(el).text();
	    }
	  };

	var eip_options_text= $.extend({text_form: '<input type="text" id="edit-#{id}" class="#{editfield_class}" value="#{value}" />'}, eip_options);

	var eip_options_textarea= $.extend({form_type: "textarea"},eip_options);
	eip_options_textarea.form_buttons= '<span><input type="button" id="save-#{id}" class="#{savebutton_class}" value="#{savebutton_text}" /> <input type="button" id="cancel-#{id}" class="#{cancelbutton_class}" value="#{cancelbutton_text}" /></span>';	
	

	// this is repeated code from product_overlay
	jQuery(settings.background).css({opacity:0.8});
	var product_overlay_bg = jQuery(settings.background+":first");
	product_overlay_bg.css({width:"0px"});
	product_overlay_bg.animate({ width:settings.width+"px" });
	overlays=jQuery(this);
	overlays.show();
	jQuery(".cerrar").click(function(){
	    overlays.hide();
	    product_overlay_bg.hide();
	    jQuery(".product-image.selected").css({background:"#fff", opacity:1});
	  });

	var brief = jQuery(".brief");
	var image_url = "/images/pizzas.jpg";

	var nombre=brief.find(".nombre");
	nombre.html("Nombre del producto");
	nombre.eip("/perfil/nombre", eip_options_text);
	brief.find(".descripcion").html("Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.").eip("/perfil/nombre", eip_options_textarea);
	brief.find(".precio").html("$999,999.00").eip("/perfil/nombre", eip_options_text);

	brief.find("#product-image-list img").attr("src",image_url);

	var $category_select= brief.find(".category-select");
	var product_type_click= function() {
	  $category_select.load("/ui/category_select .category-select>*", function() {
	      if ($category_select.css("display")=="none") $category_select.fadeIn();
	      $category_select.category_select();
	      $category_select.find(".category-list")
		.bind("category_selected", function(e,name) {
		    $("#edit-product-category").val(jQuery.trim(name));
		    $category_select.fadeOut();
		  });
	    });
	};
	var product= {};
	var category_eip_options= $.extend( {rebind:product_type_click}, eip_options, eip_options_text );
	category_eip_options.ok= function(el) {
	  eip_options.ok(el);
	  $category_select.fadeOut();
          return false;
	};

	$("#product-category")
	  .click(product_type_click)
	  .eip("/perfil/nombre", category_eip_options);
	
	var condition_eip_options=$.extend({form_type: "select"}, eip_options);
	condition_eip_options.select_options= 
	  {
	    nuevo   : "nuevo",
	    usado   : "usado"
	  }
	$("#product-condition").eip( "/perfil/nombre", condition_eip_options);

	$("#publish-product-btn").click(function() {
	    $.post("/santiago/items", $this.form_data, function(text) {
		alert(text);
	      });
	  });
      });
  }
})(jQuery);

function product_form() {
    $("#product-form").edit_product({});
}
