var csrfToken = $('meta[name="csrf-token"]').attr('content');

$(document).ready(function () {
  const table = $('#mensalidades-table').DataTable({
    "columnDefs": [
      {
        "visible": false,
        "targets": 0
      }
    ],
    paging: false,
    searching: false,
    info: false
  });

  table.on('click', 'tbody tr', function (e) {
    if (!$(e.target).is('a')) { // Dispara somente se não for o link/botão 
      e.currentTarget.classList.toggle('selected');
      $('#excluir-mensalidades').removeClass('hide')
    }
  });

  document.querySelector('#excluir-mensalidades').addEventListener('click', function () {
    $("#exclusaoModal").modal('show');
    $("#exclusaoModal").find("#qtd-mensalidades").html( table.rows('.selected').data().length);
    const idsSelecionados = table.rows('.selected').data().map(function (row) {
      return row[0] // Substitua 'ID' pelo nome da sua coluna de ID
    });
    document.querySelector('#exluir-certeza').addEventListener('click', function () {
      $.each(idsSelecionados, function (index, id) {
        $.ajax({
          url: '/mensalidades/' + id, // Endpoint com o ID na URL
          method: 'DELETE',
          headers: {
            'X-CSRF-Token': csrfToken
          }
        });
      });
    });
  });
});
