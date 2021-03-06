var zmax = 0 ;
function buildZMax() {
  var maxZ = Math.max.apply(null,$.map($('body > *'), function(e,n){
	if($(e).css('position')=='absolute')
	  return parseInt($(e).css('z-index'))||1;
      })
    );
  return maxZ;
}

jQuery(document).ready(function($) {
    if(!session)
      $("#login-modal").dialog({modal:true, autoOpen:false});
    //    alert(jQuery.browser.safari);
    meerkat({
      background:'transparent url(/images/urbanitus/the-whole-place.png) center no-repeat'
	  });
    
    /*    $("#topics").dialog({
      autoOpen: false,
      title:"topics",
	  width:150,
	  height:550,
	  draggable:false,
	  resizable:false,
	  position:[0,0]
	  });
    $("#chat").dialog({
      autoOpen: false,
      title:"chat",
	  width:240,
	  height:550,
	  draggable: true,
	  resizable:true,
	  position:[100,0]
      });

    $("#marketplace").dialog({
      autoOpen: false,
      title:"markerplace",
      width:710,
	  height:550,
	  draggable: true,
	  resizable:true,
	  position:[200,10]
	  });*/

    $.widget("ui.comic_dialog",{
      _init: function() {
	  var context= this;
	  this.browser= this.options.browser;
	  this.$tabs= $(this.options.navigation);

	  // create ui.dialog widget
	  this.element.dialog(this.options);

	  var $ui_dialog=this.element.parent(".ui-dialog");
	  $ui_dialog.prepend(this.$tabs);
	  this.$tabs.removeClass("hidden");	  
	  $ui_dialog.append($("#dialog-overlay"));

	  $(window).resize(function() {
	      //	      var width= $(window).width();
	      //var left= Math.floor((width-1000)/2)+215;
	      //$("#dialog-overlay").css("left",left);
	    });

	  
	  this.$tabs.find("li").click(function() {
	      context.$tabs.find(".selected").removeClass("selected");
	      $(this).addClass("selected");
	    });
	}
      });

    $("#community").comic_dialog({
	//autoOpen: false,
	  dialogClass: "communities",
	  width:1000,
	  height:400,
	  draggable:false,
	  resizable:false,
	  position:[150,-160],
	  navigation: ".tabs"
      });

    var eip_options = {
      savebutton_text: "ok",
      cancelbutton_text: "x",
      form_buttons: '<span><input type="button" id="save-#{id}" class="#{savebutton_class}" value="#{savebutton_text}" /> <input type="button" id="cancel-#{id}" class="#{cancelbutton_class}" value="#{cancelbutton_text}" /></span>',
      text_form: '<input type="text" id="edit-#{id}" class="#{editfield_class}" value="#{value}" />'
    };
    //    $("#myenv-profile").find(".name").eip("/perfil/nombre", eip_options);

    $.widget("ui.oeip", {
      _init: function() {
	  var self= this;
	  var label= this.options.label;
	  var edit_mode= false;
	  
	  // HTML parts
	  this.$span= $("<span/>");
	  this.$label= $("<p/>").attr("class", "oeip-label").text(label);
	  this.$input= $("<input class='edit' id=\""+label+"-edit\" type=\"text\"/>").hide();
	  this.$content= $("<p/>")
	    .attr("class", "oeip-content")
	    .text(this.options.empty_text)
	    .css("font-style","italic");

	  this.$input.blur(function() {
	      self.$input.hide();
	      var content= $.trim($(this).val());
	      content = (content == "") ? self.options.empty_text : content;
	      self.$content.text(content).show();
	    });

	  this.element
	    .append(this.$label)
	    .append(this.$span.append(this.$content).append(this.$input));

	  this.element.click(function(e) {
	      self.$input.show().focus();
	      self.$content.hide();
	    });
       	}
      });
    
    $("#myenv-profile").find(".name").oeip({label:"nombre", empty_text: "escribe tu nombre"});
    $("#myenv-profile").find(".nickname").oeip({label:"apodo",empty_text: "escribe tu apodo"});
    $("#myenv-profile").find(".birthdate").oeip({label:"cumpleaños",empty_text: "tu fecha de cumple"});
    $("#myenv-profile").find(".email").oeip({label:"correo",empty_text: "correo electrónico"});
    $("#myenv-profile").find(".location").oeip({label:"ubicación",empty_text: "dónde te encuentras"});
    $("#myenv-profile").find(".gender").oeip({label:"género",empty_text: "macho o hembra"});
    
    $("#marketplace").dialog({
      dialogClass: "communities",
      autoOpen: false,
      title:"markerplace",
      width:710,
      height:550,
      draggable: true,
      resizable:true,
      position:[200,10]
    });

    $("#meerkat").click(function(e) {
	zmax=buildZMax();
	$("#meerkat-wrap").css("z-index", zmax+1);
	var meerkat_width=1000;
	var meerkat_height=217;

	var x= e.pageX;
	var y= e.pageY;
	var viewport= {
  	  x:$(window).width(),
	  y:$(window).height()
	};
	var offset_x= Math.floor((viewport.x-meerkat_width)/2);
	var offset_y= Math.floor((viewport.y-meerkat_height));

	var menu= {
	my_env:{
	  x: [165,110],
	  y: [50,90],
	  callback: function() {
	      $("#chat").dialog("open");
	    }
	},
	my_people:{
	  x: [490,165],
	  y: [160,57]
	},
	marketplace:{
	  x: [248,107],
	  y: [142,64],
	  callback: function() {
	      $("#marketplace").dialog("open");
	    }
	}
	};

	var mi_casa_x=[165,100];
	var mi_casa_y=[50,90];
	var mi_casa_min_x= mi_casa_x[0]+offset_x;
	var mi_casa_max_x= mi_casa_min_x+mi_casa_x[1];
	var mi_casa_min_y= mi_casa_y[0]+offset_y;
	var mi_casa_max_y= mi_casa_min_y+mi_casa_y[1];
	//	alert("viewport.x:"+viewport.x+"; viewport.y:"+viewport.y+"; x:"+x+"; y:"+y);
	
	for(option in menu) {
	  var min_x= menu[option].x[0]+offset_x;
	  var max_x= min_x+menu[option].x[1];
	  var min_y= menu[option].y[0]+offset_y;
	  var max_y= min_y+menu[option].y[1];
	  if (x > min_x && x < max_x && y > min_y && y < max_y)
	    menu[option].callback();
	}
      });

    // canvas shit
    /*    var canvas= $("#canvas").get(0);
    var context= canvas.getContext("2d");
    canvas.setAttribute('width', 1200);
    canvas.setAttribute('height', 464);
    context.fillRect(150,51,1000,415);*/

}); //ends
