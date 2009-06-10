(function() {
  var SCROLL_VALUE = 367;

    //var tabView = new YAHOO.widget.TabView('tabs');

    //    var product_list = YAHOO.util.Selector.query('.product-list');

    var scrollFrom = 0;
    var scrollTo = 0;

    var recalculate_scroll = function(dir) {
      var scrolls = false;
      var scroll_attrs = {
	scroll: { to: [0, scrollTo] }
      };

      if (dir == 1) {
	  if (scrollTo/SCROLL_VALUE < 2) {
	    scrolls = true;
	  }
      } else if (dir == -1) {
	  if (scrollTo/SCROLL_VALUE > 0) {
	    scrolls = true;
	  }
      }

      if (scrolls) {
	scrollTo += SCROLL_VALUE*dir;
	scroll_attrs = {
	  scroll: { to: [0, scrollTo] }
	};	
	var scroll = new YAHOO.util.Scroll("product-list", scroll_attrs); 
	scroll.animate();
      }
    }

    YAHOO.util.Event.on('abajo', 'click', function() {
      recalculate_scroll(1);
    });

    YAHOO.util.Event.on('arriba', 'click', function() {
      recalculate_scroll(-1);
    });
})();
