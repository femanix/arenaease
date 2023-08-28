
$(function() {
  
  $('#aluno_endereco_attributes_cep').on('blur', function() {
    var cep = $(this).val();
    if (cep.length == 8) {
      $.ajax({
        url: 'https://viacep.com.br/ws/' + cep + '/json/',
        dataType: 'json',
        success: function(data) {
          $('#aluno_endereco_attributes_rua').val(data.logradouro);
          $('#aluno_endereco_attributes_bairro').val(data.bairro);
          $('#aluno_endereco_attributes_cidade').val(data.localidade);
          $('#aluno_endereco_attributes_estado').val(data.uf);
        }
      });
    }
  });
});

// SELECTIZE 
var csrfToken = $('meta[name="csrf-token"]').attr('content');

$('#matricularModal').on('shown.bs.modal', function() {
  $(".agendaSelectize").selectize({
    maxItems: null,
    valueField: 'id',
    labelField: 'day',
    searchField: 'day'
  });
})

// CPF MASK 

window.onload = function() {

};

$(function () {
  var cpfInput = document.getElementById('aluno_cpf');
  maskCpf(cpfInput);

  var telefoneInputs = document.querySelectorAll('.telefone');
  for (var i = 0; i < telefoneInputs.length; i++) {
    var telefoneInput = telefoneInputs[i];
    maskTel(telefoneInput);
  };
})
