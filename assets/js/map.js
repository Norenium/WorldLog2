document.getElementById('show-land-id').addEventListener('click', toggleShowLandId);
document.getElementById('back').addEventListener('click', back);
setSalesList();
var lana = 'id:AS21';
var allBuildings = new Array;
console.log(typeof (allBuildings));
allBuildings.push('AN27-HC-0');
allBuildings.push('AM28-HC-2');
allBuildings.push('AN29-HC-3');
//setBuildings();

function setBuildings() {
      var lands = document.getElementsByClassName('mp');
      for (let i = 0; i < allBuildings.length; i++) {
            var building = allBuildings[i].split("-");
            //console.info(building);
            var buildingCor = building[0];
            //console.log('bc:  ' + buildingCor);
            var buildingType = building[1];
            var cors = "";
            for (let j = 0; j < lands.length; j++) {
                  var cor = lands[j].innerHTML.toString().substring(3, 7);
                  //console.log('cor: ' + cor);
                  cors += buildingCor;
                  if (cor.toString() == buildingCor) {
                        console.log('cor: ' + cor + '     -bc: ' + buildingCor);
                        switch (buildingType) {
                              case 'HC':
                                    var imgId = lands[j].nextElementSibling.id;
                                    document.getElementById(imgId).src = './assets/images/Lands/HC1.png';
                                    console.info();

                                    //.src = ""
                                    break;

                              default:
                                    break;
                        }
                  }
            }
            setTimeout(() => {
                  //console.log(cors);

            }, 500);
      }
}





function back() {
      window.location.href = './';
}

//#region  Show for Sale
var saleShow = false;
function toggleShowSale() {
      if (saleShow) {
            hideSales();
            saleShow = false;
            console.log('show sale:' + saleShow)
            document.getElementById('show-for-sale').classList.remove('btn-active');
      } else {
            showSales();
            saleShow = true;
            console.log('show sale:' + saleShow)
            document.getElementById('show-for-sale').classList.add('btn-active');
      }
}
var saleIds;// = new Array();
var saleIdsText;// = new Array();

function showSales() {
      var all = document.getElementsByClassName('mp');
      console.log('all.length: ' + all.length)
      console.info(salesList);
      saleIds = new Array();
      saleIdsText = new Array();

      for (let i = 0; i < all.length; i++) {
            for (let j = 0; j < salesList.length; j++) {
                  if (all[i].innerHTML == ('Id:' + salesList[j].landId)) {
                        console.log('all inn: ' + all[i].id);
                        saleIds.push(all[i].id);
                        saleIdsText.push(all[i].innerHTML);
                        document.getElementById(all[i].id).style.display = "block";
                        all[i].innerHTML += '<p>Price: ' + salesList[j].price + ' OP <button class="tool-btn btn-small"  id="buyLand-' + salesList[j].landId.toString() + '">Buy</button> Type: ' + salesList[j].landType + '</p>';
                        document.getElementById('buyLand-' + salesList[j].landId.toString()).addEventListener('click', function () {
                              buyLand(salesList[j].landId.toString());
                        });
                  }

            }
      }
}
function buyLand(landId) {
      //window.alert('call for buy: ' + landId);
      setCookie('buyLand', landId, 0.01);
      window.location.href = './index.html';
}

function hideSales() {
      for (let j = 0; j < saleIds.length; j++) {
            var el = document.getElementById(saleIds[j]);
            el.innerHTML = saleIdsText[j];
            // '<p>Price: ' + salesList[j].price + ' OP <br> Type: ' + salesList[j].landType + '</p>';
            el.style.display = "none";
      }

}

var salesList;// = new Array();
function setSalesList() {
      salesList = JSON.parse(getCookie('SL'));

}

//#endregion


//#region  Show Info
var idShowan = true;
function toggleShowLandId() {
      if (idShowan) {
            idShowan = false;
            console.log('show info:' + idShowan)
            document.getElementById('show-land-id').classList.remove('btn-active');
            unSetInfo();
      } else {
            idShowan = true;
            document.getElementById('show-land-id').classList.add('btn-active');
            console.log('show info:' + idShowan)
            setInfo();
      }
}

function setInfo() {
      for (let i = 0; i < 151; i++) {
            if (i == 74) { } else {
                  //console.log('set() => pixle-' + i);
                  document.getElementById('pixle-' + i).addEventListener('mouseenter', function () {
                        document.getElementById('info-' + i).style.display = "block";
                  });

                  document.getElementById('info-' + i).addEventListener('mouseenter', function () {
                        document.getElementById('info-' + i).style.display = "block";
                        document.getElementById('pixle-' + i).classList.add("pixle-hover");
                  });

                  document.getElementById('pixle-' + i).addEventListener('mouseleave', function () {
                        document.getElementById('info-' + i).style.display = "none";
                        document.getElementById('pixle-' + i).classList.remove("pixle-hover");
                  });
            }
      }


}

function unSetInfo() {
      for (let i = 0; i < 151; i++) {
            if (i == 74) { } else {
                  var el = document.getElementById('pixle-' + i),
                        elClone = el.cloneNode(true);

                  el.parentNode.replaceChild(elClone, el);

                  document.getElementById('info-' + i).style.display = "none";
                  document.getElementById('pixle-' + i).classList.remove("pixle-hover");
            }
      }
}
//#endregion



//#region Cookie
function setCookie(name, value, days) {
      var expires = "";
      if (days) {
            var date = new Date();
            date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
            expires = "; expires=" + date.toUTCString();
      }
      document.cookie = name + "=" + (value || "") + expires + "; path=/";
}
function getCookie(name) {
      var nameEQ = name + "=";
      var ca = document.cookie.split(';');
      for (var i = 0; i < ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0) == ' ') c = c.substring(1, c.length);
            if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
      }
      return null;
}
function eraseCookie(name) {
      document.cookie = name + '=; Path=/; Expires=Thu, 01 Jan 1970 00:00:01 GMT;';
}

//#endregion