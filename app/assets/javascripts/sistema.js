//= require fastclick/lib/fastclick
//= require malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar
//= require custom
//= require bootstrap-growl-ifightcrime/jquery.bootstrap-growl

var csrfToken = $('meta[name="csrf-token"]').attr('content');


function maskPrice(el){
  value = el.value
  value = value.replace('.', '').replace(',', '').replace(/\D/g, '')
  if(value == ''){
    value = "0"
  }
  const options = { minimumFractionDigits: 2 }
  const result = new Intl.NumberFormat('pt-BR', options).format(
    parseFloat(value) / 100
  )
  el.value = result  
}

function maskTel(el) {
  e = el.value
  e = e
      .replace(/\D/g, '')
      .replace(/^(\d{2})(\d)/g, '($1) $2')
      .replace(/(\d)(\d{4})$/, '$1-$2')
 el.value = e
}

function maskCpf(el) {
  e = el.value
  e = e
      .replace(/\D/g, '')
      .replace(/(\d{3})(\d)/, '$1.$2')
      .replace(/(\d{3})(\d)/, '$1.$2')
      .replace(/(\d{3})(\d{1,2})/, '$1-$2')
      .replace(/(-\d{2})\d+?$/, '$1')
  el.value = e
}