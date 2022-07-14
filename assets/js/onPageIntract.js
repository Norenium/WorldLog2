setMapDataInterval();

var myName;
var allLandIds;
var allLandTypes = new Array();
var allLands = new Array();
var myLands = new Array();
var myBuildings = new Array();
var allBuildings = new Array();
var count = 0;


// var pageLoad;
// var pageStartOP;

function pagetStartOperations() {

      //console.log('Contract has been init and operations started');
      //console.log('is My contract init: ' + isContractInit);
      getMyName().then(result => {
            //console.info(result);
            myName = result;
            document.getElementById('my-name').innerHTML = myName;
            count++;
      });


      getAllLandIds().then(result => {
            //console.log('all land ids:')
            //console.info(result);
            allLandIds = result;
            count++;
      });


      getAllLandTypes().then(res => {
            //console.log('all land Types:' + res.length)
            //console.info(res);
            allLandTypes = res;
            //console.info(allLands);
            count++;
      });


      getMyBuildings().then(result => {
            //console.log('MY Buildings:')
            //console.info(result);
            myBuildings = result;
            //console.info(myBuildings)

            count++;
      });

      getMyLands().then(result => {
            //console.log('MY myLands:')
            ////console.info(result);
            myLands = result;
            //console.info(myLands)

            count++;
      });


      getAllBuildings().then(result => {
            //console.log('all allBuildings allBuildings:')
            //console.info(result);
            allBuildings = result;
            //console.info(allBuildings)
            setBuildings();
            count++;
      });

}

function setMapData() {


      for (let i = 0; i < allLandIds.length; i++) {
            var landType;

            switch (parseInt(BigInt((allLandTypes[i]).toString()))) {
                  case 0:
                        landType = "Forest"
                        break;

                  case 2:
                        landType = "Mountain"
                        break;

                  case 3:
                        landType = "Agral"
                        break;

                  case 4:
                        landType = "Urban"
                        break;

                  default:
                        break;
            }

            var isMine = isLandMine(allLandIds[i]);
            allLands[i] = { index: i, landId: allLandIds[i], landType: landType, isMine: isMine }
      }

      isMapDataSet = true;
      console.info(allLands);
}


function isLandMine(landId) {
      for (let i = 0; i < myLands.length; i++) {

            if (myLands[i] == landId) {
                  return true;
            }

      }
      return false;
}

var isMapDataSet = false;
function setMapDataInterval() {
      var intr = setInterval(() => {
            console.log(count)
            if (!isMapDataSet) {
                  if (count > 5) {
                        setMapData();

                  }
            } else {
                  clearInterval(intr);
            }
      }, 1000);
}

//#region ======================== GLOBAL CALL CONTRACT METHODS ========================
function getMyName() {
      return new Promise(function (resolve) {
            resolve(myContract.bravoCall(31, ["0x3B04C7553AEEf9797C50127B8C5d127B8384cF71"], [""], []).then(res => {
                  return res[0];
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



//#endregion


StartContract();
StartPage();

var tr = 0;
var isStartPage = false;
var start;
var middle;
var end;
function StartPage() {
      start = Date.now();
      pageLoad = Date.now();

      if (!isStartPage) {
            var intr = setInterval(() => {
                  if (!isStartPage) {
                        //console.log('In the inte Start is: ' + isStartPage + '  tr: ' + tr);
                        tr++;

                        if (isContractInit) {
                              isStartPage = true;
                              pagetStartOperations();
                              middle = Date.now();

                        }
                  } else {
                        clearInterval(intr);
                  }
                  ////console.log(' interval turn: ' + tr);
            }, 1000);
      }
}



