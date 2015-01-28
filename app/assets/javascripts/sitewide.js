$(document).ready(function() {
    DependentFields.bind()
});

$(document).ready(function() {
	$('#slider').nivoSlider({
		startSlide:0, //Set starting Slide (0 index)
		slideshowEnd: function(){$('#slider').data('nivo:vars').stop = true;}
	});
});
