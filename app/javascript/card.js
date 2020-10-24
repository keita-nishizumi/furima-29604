const pay = () => {
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY);
  const form = document.getElementById('charge-form');
  form.addEventListener("submit", (e) => {
    e.preventDefault();

    const formData = new FormData(document.getElementById("charge-form"));

    const card = {
      number: formData.get("card_number"),
      cvc: formData.get("card_cvc"),
      exp_month: formData.get("card_exp_month"),
      exp_year: `20${formData.get("card_exp_year")}`,
    }

    Payjp.createToken(card, (status, response) => {
      if (status == 200) {
        const token = response.id;
        const form = document.getElementById('charge-form');
        const tokenObj = `<input value=${token} name='token' type='hidden'>`;
        form.insertAdjacentHTML("beforeend", tokenObj);
      } else {
        form.submit();
      }
      document.getElementById("card-number").removeAttribute("name");
      document.getElementById("card-cvc").removeAttribute("name");
      document.getElementById("card-exp-month").removeAttribute("name");
      document.getElementById("card-exp-year").removeAttribute("name");

      const formData = new FormData(document.getElementById("charge-form"));
      const XHR = new XMLHttpRequest();
      XHR.open("POST", window.location.href.replace('/new', ''), true);
      XHR.responseType = "json";
      XHR.send(formData);
      XHR.onload = () => {
        if (XHR.status !== 200) {
          alert(`Error ${XHR.status}: ${XHR.statusText}`);
          form.submit();
        } else if (!(XHR.response)) {
          form.submit();
        } else {
          alert(XHR.response.message);
          window.location.href = '/';
        }
      }
    })

  });
}
if (location.href.match(/transactions/)) {
  window.onload = pay;
}