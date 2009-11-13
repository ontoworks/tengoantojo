(function($) {
  var $tab_slider = $.tab_slider = function( settings ){
    //    $('body').tab_slider( settings );
  };

  $tab_slider.defaults = {//the defaults are public and can be overriden.
    duration:1000, //how long to animate.
    axis:'x', //which of top and left should be scrolled
    event:'click', //on which event to react.
    start:0, //first element (zero-based index)
    step:1, //how many elements to scroll on each action
    lock:true,//ignore events if already animating
    cycle:true, //cycle endlessly ( constant velocity )
    constant:true, //use contant speed ?
    horizontal:false,
    navigation:""
  };

  $.fn.tab_slider = function ( settings ) {
    settings = $.extend( {}, $tab_slider.defaults, settings );
    return this.each(function() {
	var $panels = settings.panels;
	var $container = settings.container;
	var $scroll = settings.scroll;
   
	var horizontal = true;
	if (settings.horizontal) {
	  $panels.css({
	      'float' : 'left',
		'position' : 'relative' // IE fix to ensure overflow is hidden
		});
	  // calculate a new width for the container (so it holds all panels)
	  $container.css('width', $panels[0].offsetWidth * $panels.length);
	}

	var scrollOptions = {
	  target: $scroll, // the element that has the overflow
	  items: $panels,
	  next:settings.next,
	  prev:settings.prev,
	  navigation: settings.navigation,
	  axis: 'xy',
	  //onAfter: trigger, // our final callback
	  //offset: offset,
	  duration: 500,
	  easing: 'swing'
	};
	
	$(this).serialScroll(scrollOptions);
	
	$('.right-navigation').localScroll(scrollOptions);
      });
  }
 })(jQuery);

function tab_slider() {
  $("#right-tabs")
    .tab_slider({
      panels: $('#right-tabs .right-scrollContainer > div'),
	  scroll: $('#right-tabs .right-scroll').css('overflow', 'hidden'),
	  container: $('#right-tabs .right-scrollContainer'),
	  horizontal: true
	  
	  });
}
