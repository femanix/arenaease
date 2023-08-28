$('#pagarModal').on('shown.bs.modal', function () {
  document.getElementById('submitForm').addEventListener('click', function (event) {

    var valorPago = parseFloat(document.getElementById('mensalidade_valor_pago').value.replace(',', '.'));

    if (valorPago <= 0) {
      event.preventDefault();
      $.bootstrapGrowl('Indique o valor pago!', {
        ele: 'body', // which element to append to
        type: 'danger', // (null, 'info', 'danger', 'success')
        offset: {
          from: 'top',
          amount: 75
        }, // 'top', or 'bottom'
        align: 'right', // ('left', 'right', or 'center')
        width: 250, // (integer, or 'auto')
        delay: 5000, // Time while the message will be displayed. It's not equivalent to the *demo* timeOut!
        allow_dismiss: true, // If true then will display a cross to close the popup.
        stackup_spacing: 10 // spacing between consecutively stacked growls.
      });
    }

  });
});


function format(d) { // `d` é o objeto de dados original da linha
  var html = '<dl>' + '<dt>Histórico de Pagamento:</dt>';

  $.ajax({
    url: '/cash_ins?q%5Bmensalidade_id_eq%5D=' + d + '&commit=Pesquisar',
    dataType: 'json',
    async: false, // Defina async como false para aguardar a conclusão da chamada AJAX
    success: function (data) {

      if (data.length === 0) {
        html += '<dd>Nenhum histórico de pagamento encontrado.</dd>';
      } else {
        html += data.map(function (obj) { // Ajuste para o fuso horário desejado (exemplo: UTC-3)
          var date = new Date(obj.date + 'T00:00:00-03:00');
          var formattedDate = date.toLocaleDateString('pt-BR');
          var formattedValue = (obj.value_cents / 100).toLocaleString('pt-BR', {
            style: 'currency',
            currency: 'BRL'
          });
          return('<dd>' + formattedDate + '  |  ' + formattedValue + '</dd>');
        }).join('');
      }
    },
    error: function (xhr, status, error) {
      $.bootstrapGrowl("Ocorreu um erro interno: " + error, {
        ele: 'body',
        type: 'danger'
      });
    }
  });

  html += '</dl>';

  return html; // Retorne o HTML resultante
};

$(document).ready(function () {

  var table = $('#mensalidades-table').DataTable({

    order: [
      [1, 'asc']
    ],
    paging: false,
    searching: false,
    info: false

  });


  $('#mensalidades-table tbody').on('click', '.mensalidade-history', function () {

    var tr = $(this).closest('tr');
    var row = table.row(tr);

    if (row.child.isShown()) { // This row is already open - close it
      row.child.hide();
    } else { // Open this row
      row.child(format(this.id)).show();
    }

  });
});
