
//#region  WALLET FUNCTIONS CONTRACT INIT
function isOdd(num) { return num % 2; }


function StartContract() {
      //console.log('StartContract');
      return new Promise(() => {

            checkForMetamask().then(step1 => {
                  if (step1) {
                        //console.log('checkForMetamask=>then');

                        // step 2: init contract
                        tryInitContract().then(step2 => {
                              //console.log('tryInitContract => .then')
                              startPageManager();
                              return Promise.resolve(step2);

                        }).catch(() => { return Promise.resolve(false); });
                  }
            })
      })
}



var provider;
var signer;
var hasMetamask = false;
async function checkForMetamask() {

      //console.log('checkForMetamask');
      //return new Promise(async function () {
      if (window.ethereum === undefined) {
            sendAlert('You need to install MetaMask Extention.')
            console.log('ERROR: You need to install MetaMask Extention.')
            return Promise.resolve(false);
            //return false;
      } else {
            hasMetamask = true;
            provider = new ethers.providers.Web3Provider(window.ethereum, "any");
            await provider.send("eth_requestAccounts", []).then(() => {
                  signer = provider.getSigner();
                  return Promise.resolve(true);

            });
            return Promise.resolve(true);

      }
      ///});
}

function sendAlert(msg) {
      setTimeout(() => {
            window.alert(msg);
      }, 1000)
}



var myContract;
var isContractInit = false;

function tryInitContract() {
      //console.log('tryInitContract');
      /*
      return Promise.resolve(function () {
            myContract = new ethers.Contract(contractAddress, ABI, signer);
            isContractInit = true;
            console.log('tryInitContract done.');
            return true;
      });*/

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







//#region ======================== GLOBAL CALL CONTRACT METHODS ========================


//#region =========== Read Calls ===========


//#region === Land

function getMyName() {
      return new Promise(function (resolve) {
            resolve(myContract.bravoCall(31, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [""], []).then(res => {
                  return res[0];
            }));
      })
}

function getMyId() {
      return new Promise(function (resolve) {
            resolve(
                  myContract.charlieCall(33, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [""], []).then(res => {
                        return res;
                  }));
      })
}


function getMyInventory() {
      return new Promise(function (resolve) {
            resolve(myContract.charlieCall(31, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [""], []).then(res => {
                  return res;
            }));
      })
}

function getAllLandIds() {
      return new Promise(function (resolve) {
            resolve(myContract.bravoCall(11, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [""], []).then(res => {
                  return res;
            }));
      })
}

function getAllLandTypes() {
      return new Promise(function (resolve) {
            resolve(myContract.charlieCall(11, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [""], []).then(res => {
                  return res;
            }));
      })
}

function getMyLands() {
      return new Promise(function (resolve) {
            resolve(myContract.bravoCall(12, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [""], []).then(res => {
                  return res;
            }));
      })
}



function getSellLandsPrices() {
      return new Promise(function (resolve) {
            resolve(
                  myContract.charlieCall(12, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [""], []).then(res => {
                        return res;
                  }));
      })
}

function getSellLandsId() {
      return new Promise(function (resolve) {
            resolve(myContract.bravoCall(13, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [""], []).then(res => {
                  return res;
            }));
      })
}

function getMyPermits() {
      return new Promise(function (resolve) {
            resolve(myContract.bravoCall(15, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [""], []).then(res => {
                  return res;
            }));
      })
}


function getMyBuildings() {
      return new Promise(function (resolve) {
            resolve(myContract.bravoCall(16, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [""], []).then(res => {
                  return res;
            }));
      })
}



function getAllBuildings() {
      return new Promise(function (resolve) {
            resolve(myContract.bravoCall(17, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [""], []).then(res => {
                  return res;
            }));
      })
}


// returns an uint256 array which
// result[0] is the number of seconds from 1970 to the block latest hunt happend. 0=never hnted;
// result[1] is the number of seconds user must wait after a hunt to trigger next hunt;
function getWhenCanHunt() {
      //console.log('call for when can hunt');
      return new Promise(function (resolve) {


            resolve(myContract.charlieCall(32, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [""], []).then(res => {
                  return res;
            }).catch(res => {
                  //console.log('catche res: ' + res);
                  return false;
            }));

            /*
            resolve(myContract.charlieCall(32, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [""], []).then(res => {
                  return res;
            }).error(
                  res => {
                        //window.alert(res.errorArgs);
                        console.log('error in when can hunt: ' + res.errorArgs);
                        return false;
                  }
            ));
*/
            //reject(() => { return false; })

      })
}





//#endregion

//#region === Product
function getMeatSellList() {

      return new Promise(function (resolve) {
            resolve(myContract.bravoCall(32, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [""], []).then(res => {
                  return res;
            }));
      })

}

//#endregion
//#endregion





//#region =========== Delta Calls ===========
//#region === Lands 


function _listLandToSell(landId, price) {
      myContract.deltaCall(11, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [landId, ""], [price]);
}

function _removeLandFromSellList(landId) {
      myContract.deltaCall(12, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [landId, ""], []);
}

function _buyLand(landId, price) {
      myContract.deltaCall(13, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [landId, ""], [price]);
}

function _mintPermit(PermitType, landType) {
      myContract.deltaCall(14, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [""], [PermitType, landType]);
}

function _buildBuilding(PermitId, landId) {
      myContract.deltaCall(15, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [PermitId, landId], [0, 0]);
}

function _hunt() {
      myContract.deltaCall(35, ["0x87B64804e36f20acA9052D3b4Cd7188D41b59f97"], [""], []);
}

function _eatMeat(amount) {
      myContract.deltaCall(32, ["0x87B64804e36f20acA9052D3b4Cd7188D41b59f97"], [""], [amount]);
}

//#endregion

//#region === Products 

function _sellMeat(amount, price) {
      myContract.deltaCall(36, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [""], [amount, price]);
}

function _sellMeat(amount, price) {
      myContract.deltaCall(36, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [""], [amount, price]);
}

function _cancelMeatToSell(ticketId) {
      myContract.deltaCall(37, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [""], [Number(ticketId)]);
}
//#endregion

//#region Other

function startGame(name) {

      return new Promise(function (resolve) {
            resolve(myContract.deltaCall(31, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [name, ""], []).then(res => {
                  return res;
            }));
      })

}

//#endregion
//#endregion
