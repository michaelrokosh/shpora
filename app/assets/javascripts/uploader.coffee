$(document).on 'turbolinks:load', (e) ->
  if $('.file-upload').length > 0
    initUploadForm()

$(document).on 'click', '#uploader-zone', ->
  $('#upload_files').trigger "click"


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

initUploadForm = ->
  fileInput = $('#upload_files')

  submitUrl = $('input#aws_url').val()
  uploadData = JSON.parse($('input#aws_data').val())

  fileInput.fileupload
    fileInput: fileInput
    url: submitUrl
    type: 'POST'
    formData: uploadData
    autoUpload: true
    paramName: 'file'
    dataType: 'XML'
    replaceFileInput: false

    add: (e, data) ->
      maxFileSize = 104857600 # ~ 100 MB
      types = /(\.|\/)(document|msword|pdf|docx?|pptx?|xlsx?)$/i
      file = data.files[0]
      fileType = file.type.split(/(\.|\/)/).slice(-1)[0]

      if types.test(file.type) && file.size < maxFileSize
        data.submit()
      else
        message = ""
        if !types.test(file.type)
          message += "Upload attachment type is not allowed. "
        if file.size > maxFileSize
          message += "Attachment size is too big. Maximum size is 100MB. "
        alert(message)

    start: (e, data) ->
      $('.uploader-text').addClass('_hidden')
      $('#uploader-start').removeClass('_hidden')

    progress: (e, data) ->
      progress = parseInt(data.loaded / data.total * 100, 10)
      $('#uploader-start .text-danger').text(progress + "%")

    done: (e, data) ->
      amazonUrl = $(data.jqXHR.responseText).find("Location").text()
      file = data.files[0]
      fileName = file.name.split('.')[0]

      pageParams = {
        'page[file_url]': amazonUrl
        'page[title]': fileName
      }
      $.ajax
        url: "/uploads"
        type: 'post'
        dataType: 'json'
        data: pageParams

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
      , 1000);

    fail: (e, data) ->
      $('.uploader-status').addClass('_hidden')
      $('#uploader-fail').removeClass('_hidden')
