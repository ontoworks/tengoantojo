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
    return this.each(function() {
	var eip_options = 
	  {
	  savebutton_text: "ok",
	  cancelbutton_text: "x",
	  form_buttons: '<span><input type="button" id="save-#{id}" class="#{savebutton_class}" value="#{savebutton_text}" /> <input type="button" id="cancel-#{id}" class="#{cancelbutton_class}" value="#{cancelbutton_text}" /></span>',
	  text_form: '<input type="text" id="edit-#{id}" class="#{editfield_class}" value="#{value}" />'
	  };

	var eip_options_textarea = 
	  {
	  savebutton_text: "ok",
	  cancelbutton_text: "x",
	  form_buttons: '<span><input type="button" id="save-#{id}" class="#{savebutton_class}" value="#{savebutton_text}" /> <input type="button" id="cancel-#{id}" class="#{cancelbutton_class}" value="#{cancelbutton_text}" /></span>',
	  form_type: "textarea"
	  };


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
	nombre.eip("/perfil/nombre", eip_options);
	brief.find(".descripcion").html("Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.").eip("/perfil/nombre", eip_options_textarea);
	brief.find(".precio").html("$999,999.00").eip("/perfil/nombre", eip_options);

	brief.find("#product-image-list img").attr("src",image_url);

	var $category_select= $("#product-type").parent().find(".category-select");
	var product_type_click= function() {
	  $category_select.load("/ui/category_select .category-select>*", function() {
	      if ($category_select.css("display")=="none") $category_select.fadeIn();
	      $category_select.category_select();
	      $category_select.find(".category-list")
		.bind("category_selected", function(e,name) {
		    $("#edit-product-type").val(jQuery.trim(name));
		    $category_select.fadeOut();
		  });
	    });
	};
	var type_eip_options= $.extend( {ok:{}, rebind:product_type_click}, eip_options );
	type_eip_options.ok= function() {
	  $category_select.fadeOut();
          return false;
	};

	$("#product-type")
	  .bind("click", product_type_click)
	  .eip("/perfil/nombre", type_eip_options);
	
	$(".condicion").eip( "/perfil/nombre", {
	    form_type: "select",
	    select_options: {
              nuevo   : "Nuevo",
              usado   : "Usado"
		}
	  } );
      });
  }
})(jQuery);

function product_form() {
    $("#product-form").edit_product({});
}
