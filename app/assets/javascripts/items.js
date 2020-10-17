const item = () => {
  console.log('year');
  const itemPrice = document.getElementById('item-price');
  itemPrice.addEventListener('input', () => {
    const feeRate = document.getElementById('item_fee_rate').value;
    const addTaxPrice = document.getElementById('add-tax-price');
    const fee = Math.floor(itemPrice.value * feeRate);
    addTaxPrice.innerHTML = fee;
    const profit = document.getElementById('profit');
    profit.innerHTML = itemPrice.value - fee;
  })

  const profit = document.getElementById('profit');
  profit.innerHTML = 'aaa';
}

item();