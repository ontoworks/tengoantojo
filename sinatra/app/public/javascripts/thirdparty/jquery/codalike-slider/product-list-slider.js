// when the DOM is ready...
function product_list_slider() {

  var $panels1 = $('#product-list-0 .product-list-scrollContainer > div'); 
  var $container1 = $('#product-list-0 .product-list-scrollContainer');

  // if false, we'll float all the panels left and fix the width 
  // of the container
  var horizontal1 = false;
  
  // float the panels left if we're going horizontal
  if (horizontal1) {
    $panels1.css({
      'float' : 'left',
      'position' : 'relative' // IE fix to ensure overflow is hidden
    });
    
    // calculate a new width for the container (so it holds all panels)
    $container1.css('width', $panels1[0].offsetWidth * $panels1.length);
  }
  
  // collect the scroll object, at the same time apply the hidden overflow
  // to remove the default scrollbars that will appear
  var $scroll1 = $('#product-list-0 .product-list-scroll').css('overflow', 'hidden');

  // apply our left + right buttons
  /*$scroll
    .before('<img class="scrollButtons left" src="images/scroll_left.png" />')
    .after('<img class="scrollButtons right" src="images/scroll_right.png" />');*/
  
  // handle nav selection
  function selectNav1() {
    var parents = $(this).parents('ul:first').find('a');
    $(this)
      .parents('ul:first')
        .find('a')
          .removeClass('selected')
        .end()
      .end()
      .addClass('selected');
  }
  
  $('#tab-control-container').find('a').click(selectNav1);
  
  // go find the navigation link that has this target and select the nav
  function trigger1(data) {
    /*var el = $('#tab-control-container').find('a[href$="' + data.id + '"]').get(0);
    selectNav1.call(el);*/
    //alert(el);
  }
  
  if (window.location.hash) {
    trigger1({ id : window.location.hash.substr(1) });
  } else {
    //alert($('ul.product-list-navigation a:first').attr("id"));
    $('#tab-control-container a:first').click();
  }
  
  // offset is used to move to *exactly* the right place, since I'm using
  // padding on my example, I need to subtract the amount of padding to
  // the offset.  Try removing this to get a good idea of the effect
  var offset1 = parseInt((horizontal1 ? 
			 $container1.css('paddingTop') : 
			 $container1.css('paddingLeft')) 
			|| 0) * -1;
  
  
  var scrollOptions1 = {
    target: $scroll1, // the element that has the overflow
  
    // can be a selector which will be relative to the target
    items: $panels1,
  
    //navigation: '.product-list-navigation a',
  
    // selectors are NOT relative to document, i.e. make sure they're unique
    prev: 'button#arriba', 
    next: 'button#abajo',
  
    // allow the scroll effect to run both directions
    axis: 'xy',
  
    //onAfter: trigger1, // our final callback
  
    //offset: offset1,
  
    // duration of the sliding effect
    duration: 500,
  
    // easing - can be used with the easing plugin: 
    // http://gsgd.co.uk/sandbox/jquery/easing/
    easing: 'swing'
  };
  
  // apply serialScroll to the slider - we chose this plugin because it 
  // supports// the indexed next and previous scroll along with hooking 
  // in to our navigation.
  $('#product-list-0').serialScroll(scrollOptions1);
  
  // now apply localScroll to hook any other arbitrary links to trigger 
  // the effect
  //$('.product-list-navigation').localScroll(scrollOptions1);
  
  // finally, if the URL has a hash, move the slider in to position, 
  // setting the duration to 1 because I don't want it to scroll in the
  // very first page load.  We don't always need this, but it ensures
  // the positioning is absolutely spot on when the pages loads.
  scrollOptions1.duration = 1;
  //$('.product-list-navigation').localScroll.hash(scrollOptions1);
  
};
