var phrases = [];
var defaultUser = "";
var userPattern = "%USERNAME%";
var API_URL = "https://sheets.googleapis.com/v4/spreadsheets/17qf7fRewpocQ_TT4FoKWQ3p7gU7gj4nFLbs2mJtBe_k/values/A2:A103";
var API_KEY = "?key=AIzaSyDExsxzBLRZgPt1mBKtPCcSDyGgsjM3_uI";

function reactOnAction() {
    setTimeout(getRandomPhrase(), Math.round(Math.random() * 10));
}

function move() {
    //TODO
}

function calculateSpeakInterval(phrase)
{
    var lettersCount = phrase.replace(/\s+/g, '').length;
    var letterSpeakTime = 800; //msecs
    return lettersCount * letterSpeakTime;
}

function getRandomPhrase()
{
    if (typeof phrases !== 'undefined' && phrases.length > 0) {
        balloon.label = phrases[Math.round( Math.random() * phrases.length )].toString().replace(userPattern, defaultUser);
    } else {
        getPhrases();
    }

}

function getPhrases() {
    var request = new XMLHttpRequest();
    request.open('GET', "https://sheets.googleapis.com/v4/spreadsheets/17qf7fRewpocQ_TT4FoKWQ3p7gU7gj4nFLbs2mJtBe_k/values/A2:A105?key=AIzaSyDExsxzBLRZgPt1mBKtPCcSDyGgsjM3_uI")

    request.onreadystatechange = function() {
        if(request.readyState === XMLHttpRequest.DONE)
        {
            console.log("response got! ", request.responseText.length);
            var result = JSON.parse(request.responseText);
            phrases = result["values"];
        }
        if(request.status !== 200) {
            console.log("Can't connect to network, status code: ", request.status);
        }
    }

    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send();
}
