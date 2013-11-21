(function() {
  CKEDITOR.editorConfig = function(config) {
    config.language = 'ru';
    config.width = '725';
    config.height = '600';
    config.toolbar_Pure = [
      {
        name: 'document',
        items: ['Source', 'DocProps', 'Templates']
      }, {
        name: 'tools',
        items: ['Maximize']
      }, {
        name: 'basicstyles',
        items: ['Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript', '-', 'RemoveFormat']
      }, {
        name: 'paragraph',
        items: ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock']
      }, {
        name: 'links',
        items: ['Link', 'Unlink', 'Anchor']
      }, '/', {
        name: 'styles',
        items: ['Styles', 'Format', 'Font', 'FontSize']
      }, {
        name: 'colors',
        items: ['TextColor', 'BGColor']
      }, {
        name: 'insert',
        items: ['Image', 'Table', 'HorizontalRule', 'SpecialChar']
      }
    ];
    config.toolbar = 'Pure';
    return true;
  };

}).call(this);
