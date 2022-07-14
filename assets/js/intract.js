StartContract();
/*
function getWhenCanHunt() {
      myContract.charlieCall(32, ["0x87B64804e36f20acA9052D3b4Cd7188D41b59f97"], [""], []).then(res => {

            console.log('res: ' + res);
            var tim = new Date(Number(res * 1000));
            console.log('latest hunt hunt: ' + tim);

            var timT = new Date(Number((res + 600) * 1000));
            console.log(' next hunt: ' + timT);

            var nw = (new Date()).getTime() / 1000;
            console.log(' till to next hunt: ' + (res + 600) - nw);

            if (true) { // condition needed to be implement
                  document.getElementById('hunt-btn').style.display = "block";
                  document.getElementById('hunt-btn').addEventListener('click', Hunt);
            }
      })
}
*/
function EatMeat() {
      var amount = document.getElementById('eat-meat-inp').value;
      myContract.deltaCall(32, ["0x87B64804e36f20acA9052D3b4Cd7188D41b59f97"], [""], [amount]).then(res => {
            console.log('Eat meat done');
      })
}

function Hunt() {
      myContract.deltaCall(35, ["0x87B64804e36f20acA9052D3b4Cd7188D41b59f97"], [""], []).then(res => {
            console.log('Hunt doen: ');
      })
}


var myName = "";
let land = new Array();


var myLands = new Array();
var allLandsType = new Array();;
var allLands;

//#region FETCH contract data methods

function setPageData() {
      //getMyName();
      myContract.charlieCall(31, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [""], []).then(res => {
            //console.log('6 res: ' + res[8]);

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
      }
      );
      setLandData();
      getWhenCanHunt().then(res => {
            if (res == false) {
                  console.log('getWhenHunt FALSE ');
                  console.log('getWhenHunt from intract. res:' + res);

            }
            console.log('getWhenHunt from intract. res:' + res);
      });
};
var pricesArray;
var landIdArray;

function setLandData() {
      //console.log('setLandData Started');


      myContract.charlieCall(11, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [""], []).then(res => {


            for (let i = 0; i < res.length; i++) {


                  switch (parseInt(BigInt((res[i]).toString()))) {
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
            // console.log('all lands [4] value:' + allLandsType[2])
            // console.log('all lands Types =========>>>>' )

            // console.info(allLandsType)
      });

      myContract.bravoCall(11, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [""], []).then(res => {
            allLands = res;
            // console.log('all lands Type:')
            // console.info(res)


            myContract.bravoCall(12, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [""], []).then(res => {

                  var myLandIds = res;
                  // console.log('------------my land ids');
                  // console.info(allLands);
                  // console.info(myLandIds);
                  if (myLandIds.length > 0) {
                        myLandIds.forEach(element => {
                              for (let i = 0; i < allLands.length; i++) {
                                    if (element == allLands[i]) {

                                          //console.log('set myLands types: ' +BigInt(allLandsType[i]._hex))
                                          //myLands.push({ landId: allLands[i], landType: parseInt(BigInt((allLandsType[i]._hex).toString())) });
                                          myLands.push({ landId: allLands[i], landType: allLandsType[i] });

                                    }


                              }

                        });

                        setMyLands();
                        getWhenCanHunt();
                  }

            });
      });



      myContract.charlieCall(12, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [""], []).then(res => {

            //console.log('setLandData 2 ');
            var salesList = new Array();

            pricesArray = res;
            // console.info(res);
            myContract.bravoCall(13, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [""], []).then(ret => {
                  // console.log('ret: ====>');
                  // console.info(ret)
                  // console.log('allLands: ====>');
                  // console.info(allLands)
                  // console.log('allLandsType: ====>');
                  // console.info(allLandsType)
                  landIdArray = ret;
                  var row = document.getElementById('sell-list');
                  //console.log('allLands.length: '+allLands.length); 20

                  for (let i = 0; i < ret.length; i++) {
                        var myClass;

                        for (let j = 0; j < allLands.length; j++) {
                              if (ret[i] == allLands[j]) {
                                    //console.log('ret[i]: ' + ret[i] + '  allLands[j]: ' + allLands[j] + '   j: ' + j)
                                    myClass = allLandsType[j];
                              }

                        }
                        // console.log('sell land list item ' + i + ' id :' + landIdArray[i]
                        //       + '  price: ' + pricesArray[i]);

                        var n = Math.floor(Math.random() * 10);
                        var el = '<div class="land-for-sale" id="' + landIdArray[i] + '-sale"> <div class=" row col-12"> <img src="assets/images/Avatars/Avatar (' + n + ').svg" alt="profile thumnail" class="col-1 lfs-img"> <p class="col-3">Land Id: ' +
                              landIdArray[i] + '</p> <p class="col-3">Seller: Darth Vader</p> <p class="col-4">Price: ' + pricesArray[i] + ' OP <span class="' + myClass + '">' + myClass + '</span> </p> <div class="col-1"> <button type="button" class="btn btn-sm btn-primary float-end " onclick="buyLand(\''
                              + landIdArray[i] + '\',' + pricesArray[i] + ')"> Buy </button> </div></div> </div>';

                        row.innerHTML += el;

                        salesList.push({ landId: landIdArray[i], landType: myClass, price: parseInt(pricesArray[i]) })
                  }
                  setCookie('SL', JSON.stringify(salesList), 5);
                  // console.log('----salesList----');
                  // console.info(salesList);
                  var toBuyLand = getCookie('buyLand');
                  if (toBuyLand) {
                        //window.alert('call for buy ' + toBuyLand);
                        //console.log('try to go to '+toBuyLand+"-sale")
                        var elementX = document.getElementById(toBuyLand + "-sale");
                        eraseCookie('buyLand');
                        elementX.scrollIntoView();
                  }
                  setMarketData();
                  setMyPermits();
                  setMyBuildings();
            }
            );
      }
      );

};


function setMarketData() {

      myContract.bravoCall(32, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [""], []).then(res => {
            if (res.length > 0) {
                  console.log('market => Meat sell list: ---------- ')
                  console.info(res);
            }

      });

}

function setMyBuildings() {

      myContract.bravoCall(16, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [""], []).then(res => {
            console.info(res);

            if (res.length > 0) {
                  console.log('----- my Buildings: ---')
                  console.info(res);
                  document.getElementById('no-building').style.display = "none";
                  document.getElementById('loading-building').style.display = "none"


                  for (let i = 0; i < res.length; i++) {

                        var type1;
                        const myArray = res[i].split("-");
                        var type0 = myArray[1];
                        var theClass;
                        switch (type0) {
                              case 'HC':
                                    type1 = 'Hunting camp'
                                    theClass = 'Forest'
                                    break;
                              case 'WF':
                                    type1 = 'Wheat Farm'
                                    theClass = 'Agral'
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
                        document.getElementById('my-buildings-list').innerHTML += '<div class="my-land-row d-flex justify-content-between">' +
                              '<span>Building Id: ' + res[i] + '</span>'
                              + '<span> <a class="" onclick="seeOnMap(\'' + res[i] + '\')">See On Map</a></span>' +
                              '         <span> Building Type: <span class="' + theClass + '">' + type1 + '</span></span>      </div>';

                  }

            } else {
                  document.getElementById('no-building').style.display = "block"
                  document.getElementById('loading-building').style.display = "none"
            }
      });

}

function setMyPermits() {

      myContract.bravoCall(15, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [""], []).then(res => {

            if (res.length > 0) {
                  console.log('----- my permits: ---')
                  console.info(res);
                  document.getElementById('no-permit').style.display = "none";
                  for (let i = 0; i < res.length; i++) {

                        var type0 = res[i].substring(0, 2);
                        var type1;
                        var theClass;
                        switch (type0) {
                              case 'HC':
                                    type1 = 'Hunting camp'
                                    theClass = 'Forest'
                                    break;
                              case 'WF':
                                    type1 = 'Wheat Farm'
                                    theClass = 'Agral'
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
                        document.getElementById('my-permits-list').innerHTML += '<div class="my-land-row d-flex justify-content-between">' +
                              '<span>Permit Id: ' + res[i] + '</span>'
                              +
                              '         <span> Permit Type: <span class="' + theClass + '">' + type1 + '</span></span>      </div>';

                  }
            }
      });

}


function setMyLands() {
      var myLandsDiv = document.getElementById('my-lands');
      // console.log('#My Lands 01');
      // console.info(myLands);
      // console.log(myLands[13]);
      // console.log(myLands[19]);



      for (let i = 0; i < myLands.length; i++) {


            myLandsDiv.innerHTML += '<div class="my-land-row d-flex justify-content-between">' +
                  '<span>LandId: ' + myLands[i].landId + '</span>' +
                  '         <span> LandType: <span class="' + myLands[i].landType + '">' + myLands[i].landType + '</span></span>      </div>';
      }

}

//#endregion

function normalize(inp) {
      return inp / Math.pow(10, 18);
}

function start() {

      document.getElementById("main-waiting").style.display = 'block';

      var name = document.getElementById('start-name').value;
      //console.log('start called.    name: ' + name);
      myContract.deltaCall(31, ["0xF6Aeab6EA7a65F7f1A0e4C76739Ec899403B05BE"], [name, ""], []).then(() => {
            //console.log('#=> delta 31');
            setTimeout(function () {
                  window.location.reload();
                  //document.getElementById("main-waiting").style.display = 'block';

                  //window.alert('1000')
            }, 9000);
      });
}

function getMyName() {
      document.getElementById("main-waiting").style.display = 'block';

      myContract.bravoCall(31, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [""], []).then(res => {
            //myContract.name().then(res=>{
            document.getElementById("main-waiting").style.display = 'none';

            //console.log('NAME: =====>>>:  ');
            //console.info(res);
            if (res[0] == "") {
                  //console.log('NO NAME <<');
                  setTimeout(function () {
                        document.getElementById('start-div').style.display = 'block';
                  }, 1000);

            } else {
                  myName = res[0];
                  //console.log('HAS NAME :' + res[0]);
                  document.getElementById('start-div').style.display = 'none';
                  document.getElementById('boards-container').style.display = 'block';
                  document.getElementById('my-name').innerHTML = res[0];
                  setPageData();
            }

      });

}

function buyLand(landId, price) {
      //console.log('Call for buy land id: ' + landId);
      myContract.deltaCall(13, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [landId, ""], [price]).then(res => {
            //console.info(res)
      });
}

function listLand() {
      var landId = document.getElementById('sell-landId').value;
      var price = document.getElementById('sell-price').value;
      //console.log('Call for sell land -  id: ' + landId + '   price: ' + price);
      myContract.deltaCall(11, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [landId, ""], [price]).then(res =>
      //console.info(res)
      { });
}

function mintPermit() {
      var landType = document.getElementById('mint-land-type-select').value;
      var PermitType = document.getElementById('mint-permit-type-select').value;
      console.log('Call for mint permit - ' + '   permit type: ' + PermitType + '   land type: ' + landType);
      myContract.deltaCall(14, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [""], [PermitType, landType]).then(res =>
      //console.info(res)
      { });
}

function buildBuilding() {
      var landId = document.getElementById('build-landId').value;
      var PermitId = document.getElementById('build-permitId').value;
      //console.log('Call for sell land -  id: ' + landId + '   price: ' + price);
      myContract.deltaCall(15, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [PermitId, landId], [0, 0]).then(res =>
      //console.info(res)
      { });
}

function seeOnMap(id) {
      window.alert('Go to map and see ' + id);
}



//#region  WALLET FUNCTIONS CONTRACT INIT




async function StartContract() {
      document.getElementById('c-w-spinnet').style.display = 'block';

      console.log('Start Contract');
      // Step 1: get connect to metamask
      checkForMetamask().then(step1 => {
            if (step1) {

                  // step 2: init contract
                  tryInitContract().then(step2 => {
                        //if (window.location == 'http://127.0.0.1:8080/') {

                        document.getElementById('connect-wallet-div').style.display = 'none';
                        document.getElementById('c-w-spinnet').style.display = 'none';
                        // document.getElementById('start-div').style.display = 'block';
                        getMyName();
                        //}
                        return Promise.resolve(true);
                  })
            }
      })
}



var provider;
var signer;
var hasMetamask = false;
async function checkForMetamask() {

      if (window.ethereum === undefined) {
            sendAlert('You need to install MetaMask Extention.')
            return Promise.resolve(false);
      } else {
            hasMetamask = true;
            provider = new ethers.providers.Web3Provider(window.ethereum, "any");
            await provider.send("eth_requestAccounts", []).then(() => {
                  signer = provider.getSigner();
            });
            //console.log('step 1 done.')
            return Promise.resolve(true);
      }
}

function sendAlert(msg) {
      setTimeout(() => {
            window.alert(msg);
      }, 1000)
}



var myContract;
var isContractInit = false;

function tryInitContract() {
      try {
            myContract = new ethers.Contract(contractAddress, ABI, signer);
            isContractInit = true;
            //console.log('step 2 - contract init done.');
            return Promise.resolve(true);
      } catch (error) {
            return Promise.resolve(false);
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