import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1

Rectangle {
    property alias label: balloonInputLabel.text;
    property alias inputText: balloonUsernameInput.text;
    property alias inputTextColor: balloonUsernameInput.color;
    property alias fontSize: balloonInputLabel.font.pointSize;
    property alias show: balloonInput.visible;
    property alias source: balloonInput.source;
    property alias validator: balloonUsernameInput.validator;
    signal balloonInputAccepted();
    onBalloonInputAccepted: console.log("on accepted", balloonUsernameInput.text);
    width: 300
    height: 300
    color: "transparent"
    Image {
        id: balloonInput
        source: "assets/balloon_right_oriented.png";
        anchors.fill: parent
        Label {
            anchors.centerIn: parent
            width: (parent.sourceSize.width - 40 > 100) ? parent.sourceSize.width : 100;
            height: parent.sourceSize.height - 60
            id: balloonInputLabel
            text: ""
            textFormat: Text.AutoText
            lineHeight: 1.25
            verticalAlignment: Text.AlignVCenter
            font.family: "Anime Ace V02"
            font.weight: Font.Normal
            font.pointSize: 10
            horizontalAlignment: Text.AlignHCenter
            wrapMode: (parent.width > 100) ? Text.WordWrap : Text.Wrap;
        }
        Rectangle {
            width: 160
            height: 20
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.leftMargin: 110
            anchors.bottomMargin: 90
            TextInput {
                id:balloonUsernameInput
                focus: true
                color: "orange"
                text: "faggot"
                font.family: "Anime Ace V02"
                font.weight: Font.DemiBold
                font.pointSize: 12
                maximumLength: 11
                validator: RegExpValidator { regExp: /^[a-zA-Zа-яА-Я- ]*$/ }
                onAccepted: {
                    balloonInputAccepted();
                }
            }
        }
    }
}
