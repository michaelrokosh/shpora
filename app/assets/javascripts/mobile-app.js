//= require jquery
//= require jquery_ujs

$(function() {
  $('#make-favorite').click(function() {
    $button = $(this)
    if ( $( "#make-favorite" ).hasClass( "unfavorite" ) ) {
      $.ajax({
        type: "POST",
        url: '/' + $button.attr('data-user-username') + '/favorites/' + $button.attr('data-page-id'),
        success: function() {
          $button.removeClass('unfavorite').addClass('favorite').html("<span>Добавлено в избранное</span>"); ; 
        }
      })
    } else {
      $.ajax({
        type: "DELETE",
        url: '/' + $button.attr('data-user-username') + '/favorites/' + $button.attr('data-page-id'),
        success: function() {
          $button.removeClass('favorite').addClass('unfavorite').html("<span>Добавить в избранное!</span>"); 
        }
      })
    }
  });
});