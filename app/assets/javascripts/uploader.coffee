$(document).on 'turbolinks:load', (e) ->
  if $('.file-upload').length > 0
    initUploadForm()

$(document).on 'click', '#upload-preview', ->
  console.log 'hi'
  $('#content').trigger "click"


initUploadForm = ->
  form = $('form#new_document')
  fileInput = $('#content')
  submitButton = form.find('input[type="submit"]');
  submitUrl = $('input#aws_url').val()
  uploadData = JSON.parse($('input#aws_data').val())

  console.log uploadData

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
      types = /(\.|\/)(document|msword|presentation|ms-powerpoint|sheet|ms-excel|pdf|pdf|docx?|pptx?|xlsx?)$/i
      file = data.files[0]
      fileType = file.type.split(/(\.|\/)/).slice(-1)[0]

      console.log file
      console.log fileType

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
      $('.uploader-text').remove()
      $('#uploader-start').removeClass('_hidden')

    progress: (e, data) ->
      progress = parseInt(data.loaded / data.total * 100, 10)
      $('#uploader-start .text-danger').text(progress + "%")

    done: (e, data) ->
      key = $(data.jqXHR.responseXML).find("Key").text()

      console.log key

      $('#page_content_key').val(key)
      $('#page_content_processed').val(true)

      submitButton.attr('disabled', false)

      $('#uploader-start').addClass('_hidden')
      $('#uploader-done').removeClass('_hidden')

    fail: (e, data) ->
      $('.uploader-status').addClass('_hidden')
      $('#uploader-fail').removeClass('_hidden')
