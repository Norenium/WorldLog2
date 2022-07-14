
function listLand() {
      var landId = document.getElementById('sell-landId').value;
      var price = document.getElementById('sell-price').value;
      _listLandToSell(landId, price);
}

function removeListLand() {
      var landId = document.getElementById('remove-sell-landId').value;
      removeLandFromSellList(landId);
}

function buyLand(landId, price) {
      console.log('try to call buy for landId: ' + landId + '  with the price of: ' + price)
      _buyLand(landId, price);
}


function mintPermit() {
      var landType = document.getElementById('mint-land-type-select').value;
      var PermitType = document.getElementById('mint-permit-type-select').value;
      console.log('Call for mint permit - ' + '   permit type: ' + PermitType + '   land type: ' + landType);
      _mintPermit(PermitType, landType);
}

function buildBuilding() {
      var landId = document.getElementById('build-landId').value;
      var PermitId = document.getElementById('build-permitId').value;
      //console.log('Call for sell land -  id: ' + landId + '   price: ' + price);
      _buildBuilding(PermitId, landId);
}

function Hunt() {
      _hunt();
}

function EatMeat() {
      var amount = document.getElementById('eat-meat-inp').value;
      _eatMeat(amount);
}

function sellMeat() {
      var amount = document.getElementById('sell-meat-amount').value;
      var price = document.getElementById('sell-meat-price').value;
      _sellMeat(amount, price);
}

function buyMeat(ticketId, price) {
      _buyMeat(ticketId, price);
}

function start() {
      var name = document.getElementById('start-name').value;
      startGame(name).then(() => {
            setTimeout(function () {
                  window.location.reload();
            }, 9000);
      });
}

function removeSell(Id) {
      _cancelMeatToSell(Id);
}