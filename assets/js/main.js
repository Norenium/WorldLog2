document.getElementById('connect-wallet-btn').addEventListener("click", ConnctWallet);
document.getElementById('health-title').addEventListener("click", CH);

function ConnctWallet() {
      console.log('connect-wallet-btn clicked.')
      document.getElementById('connect-wallet-div').style.display = "none";
}


function CH() {
      console.log('CH clicked.')
      document.getElementById("health-bar").ariaValueNow = 50;
      document.getElementById("health-bar").style.width = '50%';
}


function waitingTest() {
      document.getElementById("main-waiting").style.display = 'block';
      setTimeout(() => {
            document.getElementById("main-waiting").style.display = 'none';

      }, 3000);
}


var acc = document.getElementsByClassName("accordion");
//var i;
setTimeout(() => {
      console.log('acc.length :  ' + acc.length);

      for (let i = 0; i < acc.length; i++) {

            acc[i].addEventListener("click", function () {
                  this.classList.toggle("active");
                  var panel = this.nextElementSibling;
                  if (panel.style.display === "block") {
                        panel.style.display = "none";
                        document.getElementById("exp-m-" + i).style.display = "block";
                        document.getElementById("exp-l-" + i).style.display = "none";
                  } else {
                        panel.style.display = "block";
                        console.log('try display :  ' + '+exp-m-' + i.toString());

                        document.getElementById('exp-m-' + i.toString()).style.display = "none";
                        document.getElementById("exp-l-" + i).style.display = "block";
                        console.log('try display exp-l-0');
                  }
            });
      }
}, 500);

