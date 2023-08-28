$('#modal-window').on('shown.bs.modal', function() {
  var cpfInput = document.getElementById('cliente_cpf');
  var telefoneInput = document.getElementById('cliente_telefone');
  maskCpf(cpfInput);
  maskTel(telefoneInput);
})
