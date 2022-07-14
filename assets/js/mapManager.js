StartContract();
document.getElementById('back').addEventListener('click', back);
document.getElementById('show-land-id').addEventListener('click', toggleShowLandId);
document.getElementById('show-for-sale').addEventListener('click', toggleShowSale);

var allBuildings = new Array;
var myLands = new Array;
function startPageManager() {
      console.log('page Manager has been called');
      getMyName().then(res => {
            console.log('My name: ' + res)
            if (res === '') {
                  window.alert('You are not in the game. Plaese signup first.')
            } else {
                  document.getElementById('my-name').innerHTML = res;
            }
      })

      getAllBuildings().then(res => {
            allBuildings = res;
            //console.info(allBuildings)
            setBuildings();
      })

      getMyLands().then(res => {
            console.log('typeof(myLands): ' + typeof (myLands))
            for (let i = 0; i < res.length; i++) {
                  myLands.push(res[i]);
            }

            var all = document.getElementsByClassName('mp');
            for (let i = 0; i < all.length; i++) {
                  for (let k = 0; k < myLands.length; k++) {
                        if (all[i].innerHTML == ('Id:' + myLands[k])) {
                              //console.log('K detection (myLands): ' + myLands[k])
                              myOwnLandsMpIds.push(all[i].id);
                        }
                  }
            }
            console.info(myOwnLandsMpIds);
            //myLands = res;
            console.log('myLands: ' + myLands)
            console.log('res.length: ' + res.length)
            console.log('typeof(res): ' + typeof (res))
            console.log('typeof(myLands): ' + typeof (myLands))
            console.info(res);
            getAndSetSellLandData();
            toggleShowLandId();
            setMyOwnLands();
      });

}
function setMyOwnLands() {
      for (let i = 0; i < myOwnLandsMpIds.length; i++) {
            document.getElementById(myOwnLandsMpIds[i]).parentNode.innerHTML += '<div class="mp2"><img src="assets/images/icons/Key2.png" alt="my own land" class="woner-logo" title="My own Land"></div>';
            console.log('Own set: ' + i)
      }
      console.log('Own set completed.')
}



//#region  Show for Sale


var sellLandsId, sellLandsPrice;
var sellLandArray = new Array();

function getAndSetSellLandData() {
      getSellLandsPrices().then(res => {
            sellLandsPrice = res;
            //sellLandArray = new Array(sellLandsPrice.length);
            console.log('sellLandsPrice.length: ' + sellLandsPrice.length)
            //document.getElementById('loading-sell-lands').style.display = "none";

            if (sellLandsPrice.length == 0) {
                  //document.getElementById('no-sell-lands').style.display = "block";
                  console.log('There are no lands to sell');
            } else {


                  getSellLandsId().then(res2 => {
                        sellLandsId = res2;
                        //console.log('*****************')
                        //console.info(allLandsId);
                        //console.info(sellLandsId);
                        for (let i = 0; i < sellLandsId.length; i++) {
                              sellLandArray.push({ landId: sellLandsId[i], price: sellLandsPrice[i] })

                              /*
                              for (let j = 0; j < sellLandsPrice.length; j++) {


                                    if (allLandsId[i] == sellLandsId[j]) {
                                          //var row = document.getElementById('sell-list');
                                          //console.log('inside the IF - j: ' + j + '    pr: ' + sellLandsPrice[j])
                                          //var n = Math.floor(Math.random() * 10);
                                          /* var el = '<div class="land-for-sale" id="' + allLandsId[i] + '-sale"> <div class=" row col-12"> <img src="assets/images/Avatars/Avatar (' + n + ').svg" alt="profile thumnail" class="col-1 lfs-img"> <p class="col-3">Land Id: ' +
                                                  allLandsId[i] + '</p> <p class="col-3">Seller: Darth Vader</p> <p class="col-4">Price: ' + sellLandsPrice[j] + ' OP <span class="' + allLandsType[i] + '">' + allLandsType[i] + '</span> </p> <div class="col-1"> <button type="button" class="btn btn-sm btn-primary float-end " onclick="buyLand(\''
                                                  + allLandsId[i] + '\',' + sellLandsPrice[j] + ')"> Buy </button> </div></div> </div>';
  
                                            row.innerHTML += el;*/
                              //console.log('j: ' + j)

                              /*
                              sellLandArray[j] = { landId: allLandsId[i], landType: allLandsType[i], price: parseInt(sellLandsPrice[j]) };
                        }
                  }
                  */
                        }

                  })
            }
            console.log('sellLandArray: ---------')
            console.info(sellLandArray)
      })


}




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
var myOwnLandsMpIds = new Array();
function showSales() {
      var all = document.getElementsByClassName('mp');
      console.log('all.length: ' + all.length)
      console.info(sellLandArray);
      saleIds = new Array();
      saleIdsText = new Array();

      for (let i = 0; i < all.length; i++) {


            for (let j = 0; j < sellLandArray.length; j++) {
                  if (all[i].innerHTML == ('Id:' + sellLandArray[j].landId)) {
                        console.log('all inn: ' + all[i].id);
                        saleIds.push(all[i].id);
                        saleIdsText.push(all[i].innerHTML);
                        document.getElementById(all[i].id).style.display = "block";
                        all[i].innerHTML += '<p>Price: ' + sellLandArray[j].price + ' OP <button class="tool-btn btn-small"  id="buyLand-' + sellLandArray[j].landId.toString() + '">Buy</button> </p>';
                        document.getElementById('buyLand-' + sellLandArray[j].landId.toString()).addEventListener('click', function () {
                              buyLand(sellLandArray[j].landId.toString(), Number(sellLandArray[j].price));
                        });
                  }

            }

      }
      var c = 0;
      console.log('all.length: ' + all.length);
      for (let i = 0; i < all.length; i++) {
            if (c < 165) {
                  //all[i].parentNode.innerHTML += '<div class="mp">***</div>'
                  //console.log(i + ' parent node: ' + all[i].parentNode);
                  c++;
            }
      }

}

function buyLand(landId, price) {
      _buyLand(landId, price);
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


//#endregion

//#region  Show Info
var idShowan = false;
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
                        //console.log('mouse in i: pixle-' + i)
                        document.getElementById('info-' + i).style.display = "block";
                  });

                  document.getElementById('info-' + i).addEventListener('mouseenter', function () {
                        //console.log('mouse in i: info-' + i)
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
