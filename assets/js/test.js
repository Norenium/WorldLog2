function addLog(title, log) {
      document.getElementById('sell-list').innerHTML += "<p>" + title + '<span class="float-end">' + log + "</span></p>";
}


StartContract().then(() => {
      getMyName().then(res => { addLog("Name: ", res); })

      getWhenCanHunt().then(res => {
            addLog("res[0]: ", res[0]); addLog("res[1]: ", res[1]);
            var check = setCountdownDisplay(res[0], res[1], 'timer-test');
            if (!check) {
                  addLog('can hunt', ' HUNT')
            }
            /* null    NaN  
            addLog('res: ' + res);
            addLog('new Date(res): ' + new Date(Number(res * 1000)));
            var now = Date.now();
            addLog('now: ' + now);
            addLog('new Date(now): ' + new Date(now));
            addLog('now - (res*1000): ' + (now - (res * 1000)));
            addLog('now - (res * 1000)): ' + (((res * 1000) - now) / 1000));*/

      })

});


//showtime(189552);



// number = number of seconds let to end;
function setCountdownDisplay(number, addition, dispalyId) {

      // test temporary
      number = (Number(number) + Number(addition)) * 1000;


      // Calculation1
      var now = Date.now();
      addLog('now: ', now)
      addLog('number: ', number)
      addLog('number-now: ', number - now)
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
      return true;

}

