jQuery(document).ready(function($) {
  /** 
   * @returns:
   * @author:
   * @version:
   * @requires:
   */
  var ProductProxy = {
    uri: Conf.Product.uri
  };
  augment(ProductProxy, Resource);

  Product.prototype.html = function() {
    this.tpl = Conf.Product.tpl();
    this.tpl.attr("id", this.id);
    this.tpl.find(".nombre").html(this.name);
    this.tpl.find(".descripcion").html(this.description);
    this.tpl.find(".product-image img").attr("src", this.image_url);
    this.tpl.find(".precio").html(this.price);
    return this.tpl;
  };

  // load all product lists
  function product_list_callback (data, list) {
    var page_size = Conf.ProductList.page_size;
    var feed = data.feed;
    var entries = feed.entry;

    var product_count = 0;
    var product_list_page_tpl;
    var new_page = false;
    for (var i=0; i<entries.length; i++) {
      var entry = entries[i];
      if (entry.g$item_type[0].$t=="Products") {
	new_page = product_count%page_size == 0 ? true : false;
	if (new_page) {
	  var page = Math.floor(product_count/page_size);
	  product_list_page_tpl = $(list.tpl.find(".product-list-page")[page]);
	  product_list_page_tpl.empty();
	}

	var product = new Product({
	  id: entry.id.$t,
	  name: entry.title.$t,
	  description: entry.content.$t,
	  image_url:entry.g$image_link ? entry.g$image_link[0].$t : "",
	  price:entry.g$price[0].$t});

	list.add(product);
	product_list_page_tpl.append(product.html().click(show_product_overlay));

	product_count++;
      }
    }
    $(".nombre").truncate({max_length: 50});
    $(".descripcion").truncate({max_length: 100});
  };

  function google_query(q, max_results) {
    var alt="json";
    var query="?q="+q+"&alt="+alt+"&max-results="+max_results;
    return query;
    }
  var product_list_query = "?q=macbook&alt=json&max-results=30";
  var product_list_0 = new ProductList({id:"product-list-0",
	proxy:ProductProxy,
	tpl:Conf.ProductList.tpl,
	callback: product_list_callback});
  product_list_0.query(google_query("macbook", 30));

  // product overlay
  // event: when btn "meantoje" clicked slide #montaje-overlay
  $(".meantoje a").click(function() {
      $(this).css({
	background:"#ccc",
	color:"#000"
	});
      $(".meantoje").css({
	background:"#ccc",
	color:"#000"
	});
      $("#meantoje-overlay").slideToggle();
    });

   jQuery('#search').keyup(function(e) {
      if(e.keyCode == 13) {
	var query = jQuery('#search').val();
	query=google_query(query, 30);
	product_list_0.query(query);
      }
      });
  

   /*****
    *
    * sliders for scrolling comments
    *
    */
   var last_x=0;
   $("#murmullo").find("#slider-vertical").slider({
     orientation: "vertical",
	 range: "min",
	 min: 0,
	 max: 1500,
	 value: 1500,
	 slide: function(event, ui) {
  	   var x=1500-ui.value;
	   var dir=1;
	   if (Math.abs(x-last_x)>15) {
	     $("#murmullo .comments-container").scrollTo(x,300);
           }
	   last_x=x;
         }
     });

   $("#product-overlay").find("#slider-vertical").slider({
     orientation: "vertical",
	 range: "min",
	 min: 0,
	 max: 1500,
	 value: 1500,
	 slide: function(event, ui) {
  	   var x=1500-ui.value;
	   var dir=1;
	   if (Math.abs(x-last_x)>15) {
	     $("#product-overlay .comments-container").scrollTo(x,300);
           }
	   last_x=x;
         }
     });
 
   /* 
    * Google Maps
    *
    */
   function initialize_google_maps() {
     var latlng = new google.maps.LatLng(6.250, -75.580);
     var myOptions = {
       zoom: 15,
       center: latlng,
       mapTypeId: google.maps.MapTypeId.ROADMAP,
       disableDefaultUI: true
     };
     var map = new google.maps.Map(document.getElementById("perfil-mapa"), myOptions);
   }
   initialize_google_maps();

   /*
    * edit in place
    *
    *
    */
   var geonames_options = {
     savebutton_text: "ok",
     cancelbutton_text: "x",
     form_buttons: '<span><input type="button" id="save-#{id}" class="#{savebutton_class}" value="#{savebutton_text}" /> <input type="button" id="cancel-#{id}" class="#{cancelbutton_class}" value="#{cancelbutton_text}" /></span>',
     text_form: '<input type="text" id="edit-#{id}" class="#{editfield_class}" value="#{value}" />',
     mode_toggle: function( self ) {
       initialize_google_maps();
       $("#perfil-mapa").slideDown();
       $("#perfil-geoname-edit").show();
       $("#perfil-geoname-edit").focus()
       $("#edit-perfil-geoname").hide();

     },
     close: function(self) {
       $("#perfil-mapa").slideUp();
       $("#perfil-geoname-edit").hide();
     },
     cancel:function(self) {
       this.close(self);
     },
     ok:function( self ) {
       this.close(self);
       alert($("#edit-perfil-geoname").val());
     }
   };

   $("#perfil-nombre").eip("/perfil/nombre", geonames_options);

   /* edit geoname */
     $(".perfil-geoname").click(function() {
	 //initialize_google_maps();
	 //$("#perfil-mapa").slideDown();
	 //$(this).unbind("click");
       });
     $("#perfil-geoname").eip("/perfil/geoname", geonames_options);

       /* autocomplete for perfil-geo */
     $("#perfil-geoname-edit").autocomplete({ 
       serviceUrl:'/geoname/search?type=json&country=CO',
	   transformer: function(query, data) {
	   var geonames=data.geonames;
	   var response={query:query,suggestions:[], data:[]};
	   $(geonames).each(function() {
	       response.suggestions.push(this.name+", "+this.countryName);
	       response.data.push(this);
	     });
	   return response;
	 }
       });
   
  }); //ends

