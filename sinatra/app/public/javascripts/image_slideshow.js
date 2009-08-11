var Image_Slideshow = function(o) {
  var opt = {
    navigation:o.navigation,
    target:o.target
  };

  // pasted from jquery.galleria
  this.scale_thumb = function(_container) {
    var _img = $(this).children("img");
    var _thumb = _img.clone(true).addClass('thumb');

    var w = Math.ceil( _img.width() / _img.height() * _container.height() );
    var h = Math.ceil( _img.height() / _img.width() * _container.width() );
    if (w < h) {
      _thumb.css({ height: 'auto', width: _container.width(), marginTop: -(h-_container.height())/2 });
    } else {
      _thumb.css({ width: 'auto', height: _container.height(), marginLeft: -(w-_container.width())/2 });
    }
    _container.append(_thumb);
  };

  $(opt.navigation).each(function() {
      this.scale_thumb($(this));
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
