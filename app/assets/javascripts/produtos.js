function adicionar(e){
    const entradaDiv = document.getElementById('entrada')
    const saidaDiv = document.getElementById('saida')
    if(e == 'Entrada'){
        saidaDiv.style.display = 'none'
        entradaDiv.style.display = 'block'
    }else{
        entradaDiv.style.display = 'none'
        saidaDiv.style.display = 'block'
    }
}

$(function() {
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

  $('#modal-window').on('shown.bs.modal', function() {
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