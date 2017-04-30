$(document).on 'turbolinks:load', (e) ->
  $("#s3-uploader").S3Uploader()

  $('#s3-uploader').bind 's3_uploads_start', (e) ->
    $('.uploader-text').addClass('_hidden')
    $('#uploader-start').removeClass('_hidden')

  $('#s3-uploader').bind "s3_upload_complete", (e, content) ->
    $('#uploader-start').addClass('_hidden')
    $('#uploader-done').removeClass('_hidden')
    $('#upload-preview').addClass('success-upload')

    self = this;
    setTimeout(->
      $('#uploader-start').removeClass('_hidden')
      $('#uploader-done').addClass('_hidden')
      $('#upload-preview').removeClass('success-upload')
      $('.uploader-status').addClass('_hidden')
      $('.uploader-text').removeClass('_hidden')
    , 2000);

  $('#s3-uploader').bind "s3_upload_failed", (e, content) ->
    $('.uploader-status').addClass('_hidden')
    $('#uploader-fail').removeClass('_hidden')


$(document).on 'click', '#uploader-zone', ->
  $('#file').trigger "click"


$(document).bind 'dragover', (e) ->
  dropZone = $('#uploader-zone')
  timeout = window.dropZoneTimeout
  if !timeout
    dropZone.addClass 'in'
  else
    clearTimeout timeout
  found = false
  node = e.target
  loop
    if node == dropZone[0]
      found = true
      break
    node = node.parentNode
    unless node != null
      break
  if found
    dropZone.addClass 'hover'
  else
    dropZone.removeClass 'hover'
  window.dropZoneTimeout = setTimeout((->
    window.dropZoneTimeout = null
    dropZone.removeClass 'in hover'
    return
  ), 100)
  return
