// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery.ui.all
//= require jquery_ujs
//= require bootstrap
//= require galleria-1.3.5
//= require galleria.classic
//= require underscore
//= require dependent-fields
//= require respond
//= require turbolinks
//= require best_in_place
//= require best_in_place.purr
//= require_tree .

$(document).ready(function() {
    DependentFields.bind()
});

$(document).ready(function() {
  jQuery('.best_in_place').best_in_place();
});


$(document).ready(function() {
	$('#slider').nivoSlider({
		startSlide:0, //Set starting Slide (0 index)
		slideshowEnd: function(){$('#slider').data('nivo:vars').stop = true;} 
	});
});
