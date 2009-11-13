function perfil() {
   /* 
    * Google Maps
    *
    */
   var perfil_mapa;
   function initialize_google_maps() {
     var latlng = new google.maps.LatLng(6.250, -75.580);
     var myOptions = {
       zoom: 15,
       center: latlng,
       mapTypeId: google.maps.MapTypeId.ROADMAP,
       disableDefaultUI: true
     };
     perfil_mapa = new google.maps.Map(document.getElementById("perfil-mapa"), myOptions);
   }

   /*
    * edit in place
    *
    *
    */
   var eip_options = {
     savebutton_text: "ok",
     cancelbutton_text: "x",
     form_buttons: '<span><input type="button" id="save-#{id}" class="#{savebutton_class}" value="#{savebutton_text}" /> <input type="button" id="cancel-#{id}" class="#{cancelbutton_class}" value="#{cancelbutton_text}" /></span>',
     text_form: '<input type="text" id="edit-#{id}" class="#{editfield_class}" value="#{value}" />'
   };

   var eip_geonames_options = {};
   $.extend(eip_geonames_options,eip_options);
   var geonames_options = {
     mode_toggle: function( self ) {
       initialize_google_maps();
       $("#perfil-mapa").fadeIn(1000);
       $("#edit-perfil-geoname").autocomplete({ 
	 serviceUrl:'/geoname/search?type=json',
	 transformer: function(query, data) {
	       var geonames=data.geonames;
	       var response={query:query,suggestions:[], data:[]};
	       $(geonames).each(function() {
		 response.suggestions.push(this.name+", "+this.countryName);
		 response.data.push(this);
	       });
	       return response;
	   },
	   onSelect:function(s,d) {
	     var latlng = new google.maps.LatLng(d.lat, d.lng);
	     perfil_mapa.set_center(latlng);
	   }
       });
     },
     close: function(self) {
       $("#perfil-mapa").fadeOut(1000);
     },
     cancel:function(self) {
       this.close(self);
     },
     ok:function( self ) {
       this.close(self);
     }
   };
   $.extend(eip_geonames_options,geonames_options);

   $("#perfil-nombre").eip("/perfil/nombre", eip_options);

   /* edit geoname */
   $("#perfil-geoname").eip("/perfil/geoname", eip_geonames_options);
   /* edit contacto */
   $("#perfil-email").eip("/perfil/email", eip_options);
   $("#perfil-telefono").eip("/perfil/telefono", eip_options);
   $("#perfil-celular").eip("/perfil/celular", eip_options);
   $("#perfil-direccion").eip("/perfil/email", eip_options);

   var perfil_slideshow = new Slideshow({
         items:".perfil-page",
	 navigation:"#perfil .perfil-navigation a",
	 target:"#perfil-content"
	 });
} //ends
