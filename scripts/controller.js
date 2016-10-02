
function welcomeInputAccepted() {
    var text = balloonWelcome.inputText;

    if(text.length > 0) {
        console.log("set default user: ", text);
        Talk.defaultUser = text;
        balloonWelcome.show = false;
        balloon.show = true;
        timer.running = true;
    } else {
        balloonWelcome.label = "Ты для меня не пустое место. Назови своё имя :)";
        console.log("your name should be at least 1 char long!");
    }
}

function setDefaultGirl() {
    var defaultGirlSource = "assets/front.png";
    return defaultGirlSource;
}
