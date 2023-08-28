var csrfToken = $('meta[name="csrf-token"]').attr('content');

$('#contratarModal').on('shown.bs.modal', function() {
  $(".selectize").selectize({
    create: function (input, callback) {
    $.ajax({
        url: '/clientes.json',
        type: 'POST',
        headers: {
        'X-CSRF-Token': csrfToken
        },
        data: { cliente: { nome_cliente: input } }
    })
    .done(function(response){
        callback({value: response.id, text: response.nome_cliente });
    })  
    }
}) 
})