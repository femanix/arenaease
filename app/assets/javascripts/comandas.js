

//const { test } = require("@rails/webpacker/package/rules/babel")

function exibPagamentos(){
    const select = document.getElementById('paymentSelect').value
    if(select == 'dinheiro'){
        exibDinheiro()
    }
    if(select == 'cartaoDebito'){
        exibCartaoDebito()
    }
    if(select == 'cartaoCredito'){
        exibCartaoCredito()
    }
    if(select == 'pix'){
        exibPix()
    }  
}

function subtrair(element){
    var el = element.closest(".itemAtual")
    var field = el.querySelector('#quantidade').value || 1
    if(field >1){
        el.querySelector('#quantidade').value = parseInt(field) - 1
        // valorTotal('diminuir')
    }     
}

function somar(element){
    var el = element.closest(".itemAtual");
    var field = el.querySelector('#quantidade').value || 0
    el.querySelector('#quantidade').value = parseInt(field) + 1
    // valorTotal('aumentar')
}

function valorTotal(type){ 
    const valor = parseInt(document.getElementById('comanda_valor_total').value)
    if(type === 'aumentar'){
        document.getElementById('comanda_valor_total').value = valor + 1
    }else{
        document.getElementById('comanda_valor_total').value = valor - 1
    }
}

function apenasNumeros(string){
    var numsStr = string.replace(/[^0-9]/g,'');
    return parseInt(numsStr);
}

//Refatorar
function exibDinheiro(){
    const exibir = document.getElementById('exibicaoDinheiro')
    exibir.style.display = "block"
    document.getElementById('exibicaoPix').style.display = 'none'
    document.getElementById('exibicaoCartaoDebito').style.display = 'none'
    document.getElementById('exibicaoCartaoCredito').style.display = 'none'
}
function exibCartaoDebito(){
    const exibir = document.getElementById('exibicaoCartaoDebito')
    exibir.style.display = "block"
    document.getElementById('exibicaoDinheiro').style.display = 'none'
    document.getElementById('exibicaoPix').style.display = 'none'
    document.getElementById('exibicaoCartaoCredito').style.display = 'none'
}
function exibCartaoCredito(){
    const exibir = document.getElementById('exibicaoCartaoCredito')
    exibir.style.display = "block"
    document.getElementById('exibicaoDinheiro').style.display = 'none'
    document.getElementById('exibicaoCartaoDebito').style.display = 'none'
    document.getElementById('exibicaoPix').style.display = 'none'
}
function exibPix(){
    const exibir = document.getElementById('exibicaoPix')
    exibir.style.display = "block"
    document.getElementById('exibicaoDinheiro').style.display = 'none'
    document.getElementById('exibicaoCartaoDebito').style.display = 'none'
    document.getElementById('exibicaoCartaoCredito').style.display = 'none'
}


// SELECTIZE

var csrfToken = $('meta[name="csrf-token"]').attr('content');
$(function() {
    $('#editModal').on('shown.bs.modal', function() {

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
})

$('#editModal').on('hidden.bs.modal', function() {
    location.reload();
})


// SELECTIZE |end
