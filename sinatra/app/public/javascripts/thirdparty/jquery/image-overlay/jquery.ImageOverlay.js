/*!
* jQuery Image Overlay v1.0.0
* http://www.ferretarmy.com/files/jQuery/ImageOverlay/ImageOverlay.html
*
* Copyright (c) 2009 Jon Neal
* Dual licensed under the MIT and GPL licenses, using the same terms as jQuery.
* Refer to http://docs.jquery.com/License
*
* Date: 2009-07-31 (Fri, 31 July 2009)
* Revision: 1.0.0
*/ 
(function($) {

	$.fn.ImageOverlay = function(options) {
		
		// Options.
		var opts = $.extend({}, $.fn.ImageOverlay.defaults, options);
		
		return this.each(function() {
		
			// Allows metadata options to be set on the field level that override plugin options
			// if the metadata plugin is installed. http://docs.jquery.com/Plugins/Metadata
			var thisOpts = $.metadata ? $.extend({}, opts, $(this).metadata()) : opts;
			
			// Move the captions below the images, so they are hidden by default.
			$('a', this).each(function() {
				
				var hrefOpts = $.metadata ? $.extend({}, thisOpts, $(this).metadata()) : thisOpts;
				
				$(this).css({
					width : hrefOpts.image_width,
					height : hrefOpts.image_height,
					borderColor : hrefOpts.border_color
				});
				$('img', this).attr({ title : '' });
			
				var imageHeight = $(this).height();
				var captionHeight = $('.caption', this).height();
				var useBottomOrigin = (hrefOpts.overlay_origin == 'top' ? false : true);
				
				if (useBottomOrigin)
				{
					// Set the CSS properties of the caption.
					$('.caption', this).css({
						top: imageHeight + 'px',
						backgroundColor: hrefOpts.overlay_color,
						color : hrefOpts.overlay_text_color
					});
					
					// Build bottom hover functionality.
					$(this).hover(function() {
						$('.caption', this).stop().animate({top: (imageHeight - captionHeight) + 'px'}, {queue: false, duration: hrefOpts.overlay_speed});
					}, function() {
						$('.caption', this).stop().animate({top: imageHeight + 'px'}, {queue: false, duration: hrefOpts.overlay_speed});
					});
				}
				else
				{
					// Set the CSS properties of the caption.
					$('.caption', this).css({
						top: -captionHeight + 'px',
						backgroundColor: hrefOpts.overlay_color,
						color : hrefOpts.overlay_text_color
					});
				
					// Build bottom hover functionality.
					$(this).hover(function() {
						$('.caption', this).stop().animate({top: '0px'}, {queue: false, duration: hrefOpts.overlay_speed});
					}, function() {
						$('.caption', this).stop().animate({top: -captionHeight + 'px'}, {queue: false, duration: hrefOpts.overlay_speed});
					});
				}
			});
			
			$(this).after('<p style="clear: both; height: 0;">&nbsp;</p>');
		});
	};
	
	$.fn.ImageOverlay.defaults = {
		border_color : '#666',
		image_height : '300px',
		image_width : '200px',
		overlay_color : '#000',
		overlay_origin : 'bottom',
		overlay_speed : 'normal',
		overlay_text_color : '#666'
	};

})(jQuery);
