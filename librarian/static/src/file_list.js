(function (window, $) {
  var fileList = $('.file-list');
  var fileRenameForms = $('.files-rename');
  var renameButton = window.templates.renameButton;
  var renameFormAlt = window.templates.renameFormAlt;

  fileList.on('click', '.files-rename-button', onRenameButtonClick);
  fileList.on('click', '.files-rename-cancel', onCancelClick);

  // Mark file list as active
  fileList.addClass('active');

  // Set up all rename forms
  fileRenameForms.each(function() {
    var el = $(this);
    var tr = el.parents('tr');
    var td = tr.find('td.name');
    var filename = td.find('a');
    var renameButtonEl = $(renameButton);
    var renameForm = $(renameFormAlt);
    var cancelButton = renameForm.find('button.files-rename-cancel');

    // Copy form data
    renameForm.find('input').val(el.find('input').val());
    renameForm.attr('action', el.attr('action'));

    // Add references to elements we'll need when handling events
    renameButtonEl.data('form', renameForm)
    renameButtonEl.data('anchor', filename);
    cancelButton.data('form', renameForm);
    cancelButton.data('anchor', filename);

    // Shuffle elements around
    el.after(renameButtonEl);
    el.remove();
    renameForm.hide();
    td.append(renameForm);
  });

  function onRenameButtonClick(e) {
    var el = $(this);
    var anchor = el.data('anchor');
    var form = el.data('form');
    anchor.hide();
    form.show();
  }

  function onCancelClick(e) {
    var el = $(this);
    var anchor = el.data('anchor');
    var form = el.data('form');
    anchor.show();
    form.hide();
  }

}(this, this.jQuery));
