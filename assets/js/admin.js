// Admin js file
// checkForMetamask();
// tryInitContract2();   ["A","B"]

function addLands() {
      var a = window.confirm('Are you rally sure about minting this lands?')
      if (a) {
            var landIds = document.getElementById('land-ids').value;

            var c = landIds.split(',').map(String);
            console.log('X1: ' + c);
            console.log('X2: ' + typeof (c));

            var landTypess = document.getElementById('land-types').value;

            console.log('#1: ' + landTypess);
            console.log('#2: ' + typeof (landTypess));
            console.log('#3: ' + parseInt(landTypess));
            var b = landTypess.split(',').map(Number);
            console.log('#4: ' + b);
            console.log('#2: ' + typeof (b));

            var landsCount = document.getElementById('land-count').value;
            console.info(c, landsCount, b);
            myLandContract.batchMint(c, landsCount, b);
      }
}