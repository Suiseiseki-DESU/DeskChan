function reactOnAction()
{
    console.log("clicked!");
    var phrases = ['lorem', 'ipsum', 'dolor', 'sit', 'amet'];
    balloonLabel.text = phrases[Math.floor( Math.random() * phrases.length )];
}


