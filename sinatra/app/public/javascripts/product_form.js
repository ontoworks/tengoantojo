(function($) {
  var $edit_product = $.edit_product = function( settings ){
    //    $('body').tab_slider( settings );
  };

  $edit_product.defaults = {//the defaults are public and can be overriden.
    width:526,
    background:".product-form-bg"
  };

  $.fn.edit_product = function ( settings ) {
    $this=this;

    // this function is called every time a new
    // product is to be published
    function initialize_product_form() {
      var after_validate= function(field, is_valid) {
	if (is_valid) {
	  $this.find("."+field.label()+" .label").css("float","none");
	  $this.find("."+field.label()+" .input-error").hide();
	} else {
	  $this.find("."+field.label()+" .label").css("float","left");
	  $this.find("."+field.label()+" .input-error").text("error al validar el valor en este campo");
	  $this.find("."+field.label()+" .input-error").show();
	}
      };
      
      var fields={
      name:{empty_text:"-- Escribe el nombre de tu producto --", match:"alpha", after_validate:after_validate},
      description:{empty_text:"-- Escribe una descripci&oacute;n de tu producto --",match:"alpha", after_validate:after_validate},
      category:{empty_text:"-- Elige una categor&iacute;a para tu producto --",match:"alpha", after_validate:after_validate},
      condition:{empty_text:"-- nuevo? usado? reparado? --",match:/nuevo|usado/, after_validate:after_validate},
      price:{empty_text:"-- Precio de venta al p&uacute;blico --",match:"currency", after_validate:after_validate}
      };

      var image_url = "/images/pizzas.jpg";
      // product-name
      $this.find("#product-name").html(fields.name.empty_text).css("font-style","italic");
      // product-description
      $this.find("#product-description").html(fields.description.empty_text).css("font-style","italic");
      // product-price
      $this.find("#product-price").html(fields.price.empty_text).css("font-style","italic");
      $this.find("#product-condition").html(fields.condition.empty_text).css("font-style","italic");
      $this.find("#product-category").html(fields.category.empty_text).css("font-style","italic");
	// set image
      $this.find("#product-image-list img").attr("src",image_url);
      
      return (new Form(fields));
    }
    
    settings = $.extend( {}, $edit_product.defaults, settings );
    return this.each(function() {
	self=this;
	var form=initialize_product_form();

	// Edit In Place options for all fields
	var eip_options = {
	  savebutton_text: "ok",
	  cancelbutton_text: "x",
	  form_buttons: '<span><input type="button" id="save-#{id}" class="#{savebutton_class}" value="#{savebutton_text}" /><input type="button" id="cancel-#{id}" class="#{cancelbutton_class}" value="#{cancelbutton_text}" /></span>',

	  before_edit: function(el) {
	    var field_label= el.id.split("-")[1];
	    var field= form.get_field(field_label);
	    $(el).html(field.value());
	  },
	  ok: function(el) {
	      // el.id contains something like 'product-name'
	      // form.fields has keys like 'product[name]'
	      var field_label= el.id.split("-")[1];
	      var field_value= $(el).text();
	      var field= form.get_field(field_label);
	      $(el).css("font-style", "normal");
	      // validate user input
	      field
	        .name(el.id.split("-")[0]+"["+field_label+"]")
	        .value(field_value)
	        .is_valid();
	      if (jQuery.trim(field_value)=="") {
		$(el).html(field.empty_text()).css("font-style","italic");
	      }
	    }
	  };
	var eip_options_text= $.extend({text_form: '<input type="text" id="edit-#{id}" class="#{editfield_class}" value="#{value}" />'}, eip_options);

	var eip_options_textarea= $.extend({form_type: "textarea"},eip_options);
	eip_options_textarea.form_buttons= '<span><input type="button" id="save-#{id}" class="#{savebutton_class}" value="#{savebutton_text}" /> <input type="button" id="cancel-#{id}" class="#{cancelbutton_class}" value="#{cancelbutton_text}" /></span>';


       	$(settings.background).css({opacity:0.8});
	var product_overlay_bg = $(settings.background+":first");
	product_overlay_bg.css({width:settings.width+"px"});
	//	product_overlay_bg.animate({ width:settings.width+"px" });
	//	product_overlay_bg.slideDown();
	overlays=$(this);
	overlays.show();
	/*$(".cerrar").click(function(){
	    overlays.hide();
	    product_overlay_bg.hide();
	    $(".product-image.selected").css({background:"#fff", opacity:1});
	    });*/

	var $category_select= $this.find(".category-select");

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
	    usado   : "usado",
	    reparado   : "reparado"
	  }

	// product-name
	$this.find("#product-name").eip("/perfil/nombre", eip_options_text);
	$this.find("#product-description").eip("/perfil/nombre", eip_options_textarea);
	$this.find("#product-price").eip("/perfil/nombre", eip_options_text);
        $this.find("#product-condition").eip( "/perfil/nombre", condition_eip_options);

	// click on "Publicar producto"
	$("#publish-product-btn").click(function() {
	    var callback= function(text) {
	      $("#product-form .brief-product").block(
	        { message:$(".product-saved-dialog"), 
		    css: { width:"52%", "border-color":"#444","border-width":"5px"} });
	      $this.find(".blockUI")
	        .css({cursor: "auto", "background-color":"#FFF"})
  	        .addClass("corner-all-8px");
	    };
	    form.post(callback);
	  });

	// product saved overlay
	$this.find(".product-saved-dialog .si").click(function() {
	    $("#product-form .brief-product").unblock();
	    form=initialize_product_form();
	    var yes_event= jQuery.Event("yes");
	    $(self).trigger(yes_event);
	  });
	$this.find(".product-saved-dialog .no").click(function() {
	    $("#product-form .brief-product").unblock();
	    var no_event= jQuery.Event("no");
	    $(self).trigger(no_event);
	  });
      });
  }
 })(jQuery);

function product_form() {
    $("#product-form").edit_product({});
}
