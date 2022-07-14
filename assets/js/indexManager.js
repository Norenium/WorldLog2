StartContract();

function ConnctWallet() {
      StartContract();
}


var myId;
var allLandsId = new Array();
var myLandsId;
var myLands = new Array();
var allLandsType = new Array();


var sellLandsId, sellLandsPrice;
var sellLandArray = new Array();
var meatSellOffers = new Array();

function startPageManager() {
      console.log('page Manager has been called');
      getMyName().then(res => {
            console.log('My name: ' + res)
            document.getElementById('connect-wallet-div').style.display = "none";
            if (res === '') {
                  console.log('No name');
                  document.getElementById('start-div').style.display = "block";
            } else {
                  document.getElementById('boards-container').style.display = "block";
                  document.getElementById('my-name').innerHTML = res;

            }
      })

      getMyId().then(res => { myId = res; console.log('my Id: ' + myId) })


      getMyInventory().then(res => {

            //console.info(res);
            //Flour
            var opousMoneyPersentage = Math.floor(res[0]);
            document.getElementById('op-val').innerHTML = opousMoneyPersentage;

            //Flour
            var electricityPersentage = Math.floor(res[1]);
            document.getElementById('mw-val').innerHTML = electricityPersentage;

            //Flour
            var WheatPersentage = Math.floor(res[2]);
            document.getElementById('wh-val').innerHTML = WheatPersentage;

            //Flour
            var BreadPersentage = Math.floor(res[3]);
            document.getElementById('br-val').innerHTML = BreadPersentage;

            //Flour
            var healthPersentage = Math.floor(res[4]);
            document.getElementById('fl-val').innerHTML = healthPersentage;

            //Meat
            var healthPersentage = Math.floor(res[5]);
            document.getElementById('mt-val').innerHTML = healthPersentage;

            //Health
            var healthPersentage = Math.floor(res[6]);
            document.getElementById('health-bar').style.width = healthPersentage + "%";
            document.getElementById('health-percentage').innerHTML = healthPersentage + "%";

            // Fat
            var fatPercentage = Math.floor(res[7] / 50);
            document.getElementById('fat-bar').style.width = fatPercentage + "%";
            document.getElementById('fat-percentage').innerHTML = fatPercentage + "%";
            document.getElementById('fat-cal').innerHTML = Math.floor(res[7]) + " Cal";


            // Energy
            var energyPercentage = Math.floor(res[8] / 10);
            document.getElementById('energy-bar').style.width = energyPercentage + "%";
            document.getElementById('energy-percentage').innerHTML = energyPercentage + "%";
            document.getElementById('energy-cal').innerHTML = Math.floor(res[8]) + " Cal";
      })

      // get all lnads and get all land types and get my lands and set my lands on the page
      getAllLandIds().then(res => {
            allLandsId = res;
            getAllLandTypes().then(res2 => {


                  //#region set landtypes to string names

                  for (let i = 0; i < res2.length; i++) {


                        switch (parseInt(BigInt((res2[i]).toString()))) {
                              case 0:


                                    allLandsType[i] = "Forest"
                                    // console.log('#My Land number ' + i + '  case 0:  type: ' + allLandsType[i]);

                                    break;

                              case 2:
                                    allLandsType[i] = "Mountain"
                                    break;

                              case 3:
                                    allLandsType[i] = "Agral"
                                    break;

                              case 4:
                                    allLandsType[i] = "Urban"
                                    break;

                              default:
                                    break;
                        }
                  }
                  //#endregion

                  getMyLands().then(res3 => {
                        myLandsId = res3;
                        //console.log('res3: ' + res3)
                        //console.log('myLandsId: ' + myLandsId)

                        if (myLandsId.length > 0) {
                              myLandsId.forEach(element => {
                                    for (let i = 0; i < allLandsId.length; i++) {
                                          if (element == allLandsId[i]) {

                                                //console.log('set myLands types: ' +BigInt(allLandsType[i]._hex))
                                                //myLands.push({ landId: allLands[i], landType: parseInt(BigInt((allLandsType[i]._hex).toString())) });
                                                myLands.push({ landId: allLandsId[i], landType: allLandsType[i] });

                                          }


                                    }

                              });

                              setMyLands();
                              //getWhenCanHunt();
                        } else {
                              document.getElementById('no-lands').style.display = "block";
                              document.getElementById('loading-lands').style.display = "none";

                        }
                  })

            })
            getAndSetSellLandData();

      })

      getMyPermits().then(res => {

            document.getElementById('loading-permits').style.display = "none";

            if (res.length > 0) {
                  //console.log('----- my permits: ---')
                  //console.info(res);
                  for (let i = 0; i < res.length; i++) {

                        var type0 = res[i].substring(0, 2);
                        var type1;
                        var theClass;
                        var explaination;
                        switch (type0) {
                              case 'HC':
                                    type1 = 'Hunting camp'
                                    theClass = 'Forest'
                                    explaination = 'Using this permit, you can build a hunting camp on your own Forest type lands.'

                                    break;
                              case 'WF':
                                    type1 = 'Wheat Farm'
                                    theClass = 'Agral'
                                    explaination = 'Using this permit, you can build a wheat farm on your own Agral type lands.'

                                    break;
                              case 'GD':
                                    type1 = 'Grinder'
                                    theClass = 'Agral'
                                    break;
                              case 'BS':
                                    type1 = 'Bakeshop'
                                    theClass = 'Urban'
                                    break;
                              case 'WM':
                                    type1 = 'WindMill'
                                    theClass = 'Urban'
                                    break;
                              case 'HS':
                                    type1 = 'House'
                                    theClass = 'Urban'
                                    break;

                              default:
                                    type1 = 'unknown'
                                    theClass = ''
                                    break;
                        }
                        //console.log('type: ' + type1);
                        document.getElementById('my-permits-list').innerHTML += '<div class="my-land-row ">' +
                              '<span class="d-flex justify-content-between"><span>Permit Id: ' + res[i] + '</span>'
                              +
                              '         <span> Permit Type: <span class="' + theClass + '">' + type1 + '</span></span></span>   <br>  <span>Info: ' + explaination + '</span> </div>';

                  }
            } else {
                  document.getElementById('no-permit').style.display = "block";

            }
      })

      getMyBuildings().then(res => {

            document.getElementById('loading-building').style.display = "none"

            if (res.length > 0) {
                  console.log('----- my Buildings: ---')
                  console.info(res);


                  for (let i = 0; i < res.length; i++) {

                        var type1;
                        const myArray = res[i].split("-");
                        var type0 = myArray[1];
                        var theClass;
                        var explaination;
                        switch (type0) {
                              case 'HC':
                                    type1 = 'Hunting camp'
                                    theClass = 'Forest'
                                    explaination = 'Owning this building you can hunt and earn meat'
                                    break;
                              case 'WF':
                                    type1 = 'Wheat Farm'
                                    theClass = 'Agral'
                                    explaination = 'Owning this building you can farm and earn wheat'
                                    break;
                              case 'GD':
                                    type1 = 'Grinder'
                                    theClass = 'Agral'
                                    break;
                              case 'BS':
                                    type1 = 'Bakeshop'
                                    theClass = 'Urban'
                                    break;
                              case 'WM':
                                    type1 = 'WindMill'
                                    theClass = 'Urban'
                                    break;
                              case 'HS':
                                    type1 = 'House'
                                    theClass = 'Urban'
                                    break;

                              default:
                                    type1 = 'unknown'
                                    theClass = ''
                                    break;
                        }
                        console.log('type: ' + type1);
                        document.getElementById('my-buildings-list').innerHTML += '<div class="my-land-row">' +
                              '<span class=" d-flex justify-content-between"><span>Building Id: ' + res[i] + '</span>'
                              + '<span> <a class="" onclick="seeOnMap(\'' + res[i] + '\')">See On Map</a></span>' +
                              '         <span> Building Type: <span class="' + theClass + '">' + type1 + '</span></span>  </span>   <br>  <span>Info: ' + explaination + '</span> </div>';

                  }

            } else {
                  document.getElementById('no-building').style.display = "block"
            }

      })


      // get When can hunt
      setTimeout(() => {

            getWhenCanHunt().then(res => {

                  console.log('ٌWhen cna hunt result: ' + res);

                  if (res == false) {
                        document.getElementById('no-hc').style.display = "block"

                  } else {
                        var check = setCountdownDisplayForHunt(res[0], res[1], 'hunt-timer', 'next-hunt');

                        if (!check) {
                              console.log('can hunt', ' HUNT')

                              document.getElementById('hunt-btn').style.display = "block"
                              document.getElementById('hunt-btn').removeAttribute('disabled');

                        }
                  }

            });


      }, 2000);


      getMeatSellList().then(res => {
            if (res.length == 0) {
                  document.getElementById('no-meat-sell-list').style.display = 'block';
            } else {
                  for (let i = 0; i < res.length; i++) {
                        console.log(res);
                        var parts = res[i].split('-');
                        console.info(parts);
                        //console.log('sell meat list [i]=' + i + '   res: ' + res);
                        meatSellOffers.push({
                              index: i, ticketId: Number(parts[0]),
                              sellerId: Number(parts[1]), amount: Number(parts[2]), price: Number(parts[3])
                        })

                  }
                  setSellMeatList();
            }
      })
}


function setSellMeatList() {
      var row = document.getElementById('meat-sell-list');

      for (let i = 0; i < meatSellOffers.length; i++) {
            var close = '';
            if (meatSellOffers[i].sellerId == myId) {
                  close = '<a title="remove from sell list" onclick="removeSell(\'' + meatSellOffers[i].ticketId + '\')"><img src="assets/images/icons/close-circle_8.svg" alt="" class="delete-icon"></a>'
                  //console.log('sell to add delete: ' + meatSellOffers[i].ticketId);
            }
            var n = Math.floor(Math.random() * 10);
            var el = '<div class="land-for-sale" id="' + meatSellOffers[i].ticketId + '-sale"> <div class=" row col-12"> <img src="assets/images/Avatars/Avatar (' + n + ').svg" alt="profile thumnail" class="col-1 lfs-img"> <p class="col-3">Meat amount: ' +
                  meatSellOffers[i].amount + '</p> <p class="col-3">Seller: ' + meatSellOffers[i].sellerId + '</p> <p class="col-3">Price: ' + meatSellOffers[i].price + ' OP  </p> <div class="col-2 "> <button type="button" class="btn btn-sm btn-primary  " onclick="buyMeat(\''
                  + meatSellOffers[i].ticketId + '\',' + meatSellOffers[i].price + ')"> Buy </button> ' + close + '</div></div> </div>';

            row.innerHTML += el;

            // <span class="' + allLandsType[i] + '">' + allLandsType[i] + '</span>
      }
}

function getAndSetSellLandData() {
      getSellLandsPrices().then(res => {
            sellLandsPrice = res;
            sellLandArray = new Array(sellLandsPrice.length);

            document.getElementById('loading-sell-lands').style.display = "none";

            if (sellLandsPrice.length == 0) {
                  document.getElementById('no-sell-lands').style.display = "block";
            } else {


                  getSellLandsId().then(res2 => {
                        sellLandsId = res2;
                        //console.log('*****************')
                        //console.info(allLandsId);
                        //console.info(sellLandsId);
                        for (let i = 0; i < allLandsId.length; i++) {

                              for (let j = 0; j < sellLandsPrice.length; j++) {


                                    if (allLandsId[i] == sellLandsId[j]) {
                                          var row = document.getElementById('sell-list');
                                          //console.log('inside the IF - j: ' + j + '    pr: ' + sellLandsPrice[j])
                                          var n = Math.floor(Math.random() * 10);
                                          var el = '<div class="land-for-sale" id="' + allLandsId[i] + '-sale"> <div class=" row col-12"> <img src="assets/images/Avatars/Avatar (' + n + ').svg" alt="profile thumnail" class="col-1 lfs-img"> <p class="col-3">Land Id: ' +
                                                allLandsId[i] + '</p> <p class="col-3">Seller: Darth Vader</p> <p class="col-4">Price: ' + sellLandsPrice[j] + ' OP <span class="' + allLandsType[i] + '">' + allLandsType[i] + '</span> </p> <div class="col-1"> <button type="button" class="btn btn-sm btn-primary float-end " onclick="buyLand(\''
                                                + allLandsId[i] + '\',' + sellLandsPrice[j] + ')"> Buy </button> </div></div> </div>';

                                          row.innerHTML += el;
                                          //console.log('j: ' + j)
                                          sellLandArray[j] = { landId: allLandsId[i], landType: allLandsType[i], price: parseInt(sellLandsPrice[j]) };
                                    }
                              }

                        }

                  })
            }
            // console.log('sellLandArray: ---------')
            // console.info(sellLandArray)
      })
}

function setMyLands() {
      var myLandsDiv = document.getElementById('my-lands');
      document.getElementById('loading-lands').style.display = "none";
      for (let i = 0; i < myLands.length; i++) {


            myLandsDiv.innerHTML += '<div class="my-land-row d-flex justify-content-between">' +
                  '<span>LandId: ' + myLands[i].landId + '</span>' +
                  '         <span> LandType: <span class="' + myLands[i].landType + '">' + myLands[i].landType + '</span></span>      </div>';
      }

}







//#region Side Methods

// number = number of seconds for the earliest user hunt from 1970;
// addition = the period user must wait untill next hunt;
// dispalyId = the HTML elemnt id where the result must been showan;
// dispalyId = the HTML elemnt id which contents the result element and used to be hidden and must be displayed now;
function setCountdownDisplayForHunt(number, addition, dispalyId, dispalyId2) {

      // test temporary
      number = (Number(number) + Number(addition)) * 1000;


      // Calculation1
      var now = Date.now();

      if (number <= now) {
            return false;
      }

      // Calculation2
      number = (((number) - now) / 1000);

      var result;
      var Days = Math.floor(number / 86400);

      var lesThanDay = number - (Days * 86400);
      var Hours = Math.floor(lesThanDay / 3600);

      var lesThanHour = lesThanDay - (Hours * 3600);
      var minutes = Math.floor(lesThanHour / 60);

      var lesThanMinute = lesThanHour - (minutes * 60);
      var Seconds = Math.floor(lesThanMinute);

      if (Days == 0) {
            result = (Hours + ' : ' + minutes + ' : ' + Seconds);
      } else {
            result = (Days + ' Day - ' + Hours + ' : ' + minutes + ' : ' + Seconds);
      }
      document.getElementById(dispalyId).innerHTML = result;
      document.getElementById(dispalyId2).style.display = "block"

      return true;

}

//#endregion