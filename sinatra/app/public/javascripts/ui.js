  /** 
   * @returns:
   * @author:
   * @version:
   * @requires:
   */
   var Slideshow = function(o) {
     var opt = {
       items:o.items,
       navigation:o.navigation,
       target:o.target
     };

     $(opt.navigation).click(function(e) {
	 var selected = $(this).attr("href");
	 var current = $(o.navigation).filter(".selected").attr("href");
	 if (current!=selected) {
	   $(o.navigation).filter(".selected").removeClass("selected");
	   $(this).addClass("selected");
	   $(selected).hide();
	   $(selected).fadeIn(1000);
	   $(current).fadeOut();
	 }
	 e.preventDefault();
       });
   };

var Component_Loader = function(o) {
};

var Ajax_Slideshow = function(o) {
  var opt = {
    navigation:o.navigation,
    target:o.target
  };

  var success = function(url) {
    return function(data, textStatus) {
      window[url]();
    };
  };

  $(opt.navigation).click(function(e) {
      var url = $(this).attr("href");
      $(opt.target).load(url, success(url));
      e.preventDefault();
    });
};

var Image_Slideshow = function(o) {
  var opt = {
    navigation:o.navigation,
    target:o.target
  };

  // pasted from jquery.galleria
  var scale_thumb = function(_container) {
    var _img = _container.children("img");

    var _thumb = _img.clone(true).addClass('thumb');

    var w = Math.ceil( _img.width() / _img.height() * _container.height() );
    var h = Math.ceil( _img.height() / _img.width() * _container.width() );

    alert(w+":"+h);

    if (w < h) {
      _thumb.css({ height: 'auto', width: _container.width(), marginTop: -(h-_container.height())/2 });
    } else {
      _thumb.css({ width: 'auto', height: _container.height(), marginLeft: -(w-_container.width())/2 });
    }
    //_container.append(_thumb.show());
  };

  $(opt.navigation).each(function() {
      var _container = $(this);
      var _img = $(this).children("img").css('display','none');
      var _loader = new Image();
      var _src = _img.attr('src');

      $(_loader).load(function () {
	  scale_thumb(_container);
	}).attr("src", _src);

    });

  $(opt.navigation).click(function(e) {
      var selected = $(this).attr("rel");
      var current = $(opt.navigation).filter(".selected").attr("rel");
      if (current!=selected) {
	$(opt.navigation).filter(".selected").removeClass("selected");
	$(this).addClass("selected");


	$(opt.target).find(".image-showcase").fadeOut(function() {
	    $(this).find(".image-showcase img").attr("src")=selected;
	    $(this).fadeIn();
	  });
      }
      e.preventDefault();
    });  
};
