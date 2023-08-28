// require turbolinks
//= require jquery/dist/jquery
//= require bootstrap/dist/js/bootstrap
//= require selectize

var csrfToken = $('meta[name="csrf-token"]').attr('content');

$('#planosModal').on('shown.bs.modal', function() {
  $(".selectize").selectize({
    plugins: ["restore_on_backspace"],
    create: function (input, callback) {
      $.ajax({
        url: '/modalidades.json',
        type: 'POST',
        headers: {
          'X-CSRF-Token': csrfToken
        },
        data: { modalidade: { descricao: input } }
      })
      .done(function(response){
        callback({value: response.id, text: response.descricao });
      })   
    }
  })  
})