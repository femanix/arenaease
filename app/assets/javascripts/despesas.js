function exibPago(){
    const item = document.getElementById('pago')
    if(item.checked){
        document.getElementById('pagamento').style.display = 'flex'
    }else{
        document.getElementById('pagamento').style.display = 'none'
    }    
}