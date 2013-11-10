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
//= require bootstrap/tooltip
//= require bootstrap/modal
//= require bootstrap/dropdown
//= require bootstrap/alert
//= require bootstrap-wysihtml5
//= require bootstrap-wysihtml5/locales

$(document).ready(function(){

    $('.editor').each(function(i, elem) {
      $(elem).wysihtml5();
    });

  })


$(function() {
  $('.close-nav').click(function() {
    if ( $( "#lock-unlock" ).hasClass( "icon-lock" ) ) {
        $('.fixed-nav').css('position', 'static');
        $('.main').css('margin-top', '35px');
        $("#lock-unlock").toggleClass('icon-lock icon-unlock');
    } else {
        $('.fixed-nav').css('position', 'fixed');
        $("#lock-unlock").toggleClass('icon-unlock icon-lock');
        $('.main').css('margin-top', '85px');
    }
  });
});

$(function() {
    $( '.nav-slider' ).click(function () {
      if ( $( ".navigation" ).is( ":hidden" ) ) {
        $( ".navigation" ).slideDown( "fast" );
      } else {
        $( ".navigation" ).hide();
      }
    });
});


