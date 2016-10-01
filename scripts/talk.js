var phrases = [];

function reactOnAction() {
    setTimeout(getRandomPhrase(), Math.floor(Math.random() * 10));
}

function move() {

}

function getRandomPhrase()
{
    if (typeof phrases !== 'undefined' && phrases.length > 0) {
        balloonLabel.text = phrases[Math.floor( Math.random() * phrases.length )].toString();
    } else {
        getPhrases();
    }

}

function getPhrases() {
    var request = new XMLHttpRequest();
    request.open('GET', "https://sheets.googleapis.com/v4/spreadsheets/17qf7fRewpocQ_TT4FoKWQ3p7gU7gj4nFLbs2mJtBe_k/values/A1:A100?key=AIzaSyDExsxzBLRZgPt1mBKtPCcSDyGgsjM3_uI")

    request.onreadystatechange = function() {
        if(request.readyState === XMLHttpRequest.DONE)
        {
            console.log("response got! ", request.responseText.length);
            var result = JSON.parse(request.responseText);
            phrases = result["values"];
        } else {
            console.log("fail :( ", request.status);
        }
    }

    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send();
}
