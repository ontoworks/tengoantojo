function right_slider() {
  var $panels = $('#right-tabs .right-scrollContainer > div');
  var $container = $('#right-tabs .right-scrollContainer');

  var horizontal = true;
  if (horizontal) {
        $panels.css({
            'float' : 'left',
            'position' : 'relative' // IE fix to ensure overflow is hidden
	      });
        // calculate a new width for the container (so it holds all panels)
        $container.css('width', $panels[0].offsetWidth * $panels.length);
  }

  var $scroll = $('#right-tabs .right-scroll').css('overflow', 'hidden');
  
  function selectNav() {
    $(this)
      .parents('ul:first')
      .find('a')
      .removeClass('selected')
      .end()
      .end()
      .addClass('selected');
  }
  
  $('#right-tabs .right-navigation').find('a').click(selectNav);

  function trigger(data) {
    var el = $('#right-tabs .right-navigation').find('a[href$="' + data.id + '"]').get(0);
    selectNav.call(el);
  }
  
  if (window.location.hash) {
    trigger({ id : window.location.hash.substr(1) });
  } else {
        $('ul.right-navigation a:first').click();
  }

  var offset = parseInt((horizontal ? 
			 $container.css('paddingTop') : 
			 $container.css('paddingLeft')) 
			|| 0) * -1;
  
  var scrollOptions = {
  target: $scroll, // the element that has the overflow
  items: $panels,
  navigation: '.right-navigation a',
  axis: 'xy',
  onAfter: trigger, // our final callback
  offset: offset,
  duration: 500,
  easing: 'swing'
  };
  
  $('#right-tabs').serialScroll(scrollOptions);
  
  $('.right-navigation').localScroll(scrollOptions);
  
  scrollOptions.duration = 1;
  $.localScroll.hash(scrollOptions);
}
