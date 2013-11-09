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
//= require bootstrap-wysihtml5
//= require bootstrap-wysihtml5/locales
//= require bootstrap/dropdown
//= require bootstrap/modal
//= require bootstrap/alert
$(document).ready(function(){

    $('.editor').each(function(i, elem) {
        $(elem).wysihtml5({
            "font-styles": true, 
            "emphasis": true,
            "lists": true, 
            "html": false, 
            "link": false, 
            "image": false, 
            "color": true 
        });
    });

})

$(function() {
  $('.close-nav').click(function() {
    if ( $( "#lock-unlock" ).hasClass( "fa-lock" ) ) {
        $('.fixed-nav').css('position', 'static');
        $("#lock-unlock").toggleClass('fa-lock fa-unlock');
    } else {
        $('.fixed-nav').css('position', 'fixed');
        $("#lock-unlock").toggleClass('fa-unlock fa-lock');
    }
  });
});

$(function() {
    $( '.nav-slider' ).click(function () {
      if ( $( ".navigation" ).is( ":hidden" ) ) {
        $( ".navigation" ).slideDown( "medium" );
      } else {
        $( ".navigation" ).hide();
      }
    });
});


$(function(){
  function initToolbarBootstrapBindings() {
    var fonts = ['Serif', 'Sans', 'Arial', 'Arial Black', 'Courier', 
          'Courier New', 'Comic Sans MS', 'Helvetica', 'Impact', 'Lucida Grande', 'Lucida Sans', 'Tahoma', 'Times',
          'Times New Roman', 'Verdana'],
          fontTarget = $('[title=Font]').siblings('.dropdown-menu');
    $.each(fonts, function (idx, fontName) {
        fontTarget.append($('<li><a data-edit="fontName ' + fontName +'" style="font-family:\''+ fontName +'\'">'+fontName + '</a></li>'));
    });
    $('a[title]').tooltip({container:'body'});
      $('.dropdown-menu input').click(function() {return false;})
          .change(function () {$(this).parent('.dropdown-menu').siblings('.dropdown-toggle').dropdown('toggle');})
      .keydown('esc', function () {this.value='';$(this).change();});

    $('[data-role=magic-overlay]').each(function () { 
      var overlay = $(this), target = $(overlay.data('target')); 
      overlay.css('opacity', 0).css('position', 'absolute').offset(target.offset()).width(target.outerWidth()).height(target.outerHeight());
    });
    if ("onwebkitspeechchange"  in document.createElement("input")) {
      var editorOffset = $('#editor').offset();
      $('#voiceBtn').css('position','absolute').offset({top: editorOffset.top, left: editorOffset.left+$('#editor').innerWidth()-35});
    } else {
      $('#voiceBtn').hide();
    }
  };
  function showErrorAlert (reason, detail) {
      var msg='';
      if (reason==='unsupported-file-type') { msg = "Unsupported format " +detail; }
      else {
          console.log("error uploading file", reason, detail);
      }
      $('<div class="alert"> <button type="button" class="close" data-dismiss="alert">&times;</button>'+ 
       '<strong>File upload error</strong> '+msg+' </div>').prependTo('#alerts');
  };
  initToolbarBootstrapBindings();  
  $('#editor').wysiwyg({ fileUploadError: showErrorAlert} );
  window.prettyPrint && prettyPrint();
});