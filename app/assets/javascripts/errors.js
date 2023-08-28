
//= require bootstrap-growl-ifightcrime/jquery.bootstrap-growl


$(function() {
  $.bootstrapGrowl('Você será redirecionado em alguns segundos...', {
    ele: 'body', // which element to append to
    type: 'null', // (null, 'info', 'danger', 'success')
    offset: {
        from: 'bottom',
        amount: 75
    }, // 'top', or 'bottom'
    align: 'right', // ('left', 'right', or 'center')
    width: 'auto', // (integer, or 'auto')
    delay: 4000, // Time while the message will be displayed. It's not equivalent to the *demo* timeOut!
    allow_dismiss: false, // If true then will display a cross to close the popup.
    stackup_spacing: 10 // spacing between consecutively stacked growls.
  });
});