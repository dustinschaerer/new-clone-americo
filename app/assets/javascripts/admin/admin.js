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
//= require jquery_ujs
//= require bootstrap.min
//= require_directory ../../../../vendor/assets/javascripts/.
//= require_directory .
//= require best_in_place
//= require jquery-ui
//= require best_in_place.jquery-ui
//= require jquery.purr
//= require best_in_place.purr
//= require underscore
//= require raphael
//= require morris
//= require ./inhouse_customer

$(document).ready(function() {
  /* Activating Best In Place */
  jQuery(".best_in_place").best_in_place();
});

$('.best_in_place').bind("ajax:success", function () {
	location(reload);
});
