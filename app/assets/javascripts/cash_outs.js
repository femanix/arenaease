function exibPago() {
  const item = document.getElementById('pago')
  if (item.checked) {
    document.getElementById('pagamento').style.display = 'flex'
  } else {
    document.getElementById('pagamento').style.display = 'none'
  }
}
$(function () {
  $('#editModal').on('shown.bs.modal', function () {

    $(".selectize-fornecedor").selectize({
      create: function (input, callback) {
      $.ajax({
          url: '/suppliers.json',
          type: 'POST',
          headers: {
            'X-CSRF-Token': csrfToken
          },
          data: { supplier: { description: input } }
        })
        .done(function(response){
          callback({value: response.id, text: response.description });
        })  
      }
    })
  })
})
