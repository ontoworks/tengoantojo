var zmax = 0 ;
function buildZMax() {
  var maxZ = Math.max.apply(null,$.map($('body > *'), function(e,n){
	if($(e).css('position')=='absolute')
	  return parseInt($(e).css('z-index'))||1 ;
	})
    );
  return maxZ;
}

jQuery(document).ready(function($) {
    meerkat({
      background:'transparent url(/images/urbanitus/the-whole-place.png) center no-repeat'
	  });

    $("#topics").dialog({
      width:150,
	  height:550,
	  draggable:false,
	  resizable:false,
	  position:[0,0]
	  });
    $("#chat").dialog({
      width:240,
	  height:550,
	  draggable: true,
	  resizable:true,
	  position:[100,0]
      });

    $("#marketplace").dialog({
      width:710,
	  height:550,
	  draggable: true,
	  resizable:true,
	  position:[200,10]
      });

    $("#community").dialog({
      width:710,
	  height:505,
	  draggable: true,
	  resizable:true,
	  position:[300,10]
      });

    var dialogs= ["#topics", "#chat", "#marketplace", "#community"];
    var all_dialogs_selector= dialogs.join(",");
    $(all_dialogs_selector).dialog("close");

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
}); //ends
