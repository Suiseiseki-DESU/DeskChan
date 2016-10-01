import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.0
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.2
import QtQuick.Window 2.0

import "scripts/talk.js" as Talk
import "ui"

ApplicationWindow {
    id: root

    property int offset: 25

    x: Screen.width - img.width - offset;
    y: Screen.height;

    visible: true
    width: Screen.width
    height: Screen.height
    title: "lorm"
    onClosing: Qt.quit();

    flags: Qt.ToolTip | Qt.FramelessWindowHint | Qt.WA_TranslucentBackground | Qt.WindowStaysOnTopHint | Qt.BypassGraphicsProxyWidget
    color: "transparent"

    Image {
        id: exitButton
        x: img.x - offset;
        y: img.y;
        z: 100;
        width: 80;
        height: 80;

        source: "assets/close.png"

        MouseArea {
            width: exitButton.width
            height: exitButton.height
            anchors.fill: parent;
            onClicked: {
                console.log("on exit cross clicked");
                Qt.quit();
            }
        }
    }

    Image {
        id: uploadButton
        x: img.x - offset;
        y: img.y + height + offset;
        z: 100;
        width: 80;
        height: 80;

        source: "assets/upload.png"

        MouseArea {
            width: uploadButton.width
            height: uploadButton.height
            anchors.fill: parent;
            onClicked: {
                selectGirlDialog.open()
                console.log("on upload");
            }
        }
    }

    Image {
            id: balloon
            visible: false

            source: "assets/balloon_right_oriented.svg"

            x: img.width + img.x
            y: img.y

            sourceSize.width: balloonLabel.contentWidth + 100
            sourceSize.height: 300

            Label {
                anchors.centerIn: parent

                width: 200
                height: parent.sourceSize.height - 20

                id: balloonLabel
                text: "Deskchan v.0.1 Preview \nDesigned and developed by Deskchan Project crew"
                textFormat: Text.AutoText
                lineHeight: 1.25
                verticalAlignment: Text.AlignVCenter
                font.family: "Anime Ace V02"
                font.weight: Font.Normal
                font.pointSize: 10
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
            }

        }

    Image {
            id: balloonWelcome

            source: "assets/balloon_right_oriented.svg"

            x: img.width + img.x
            y: img.y

            sourceSize.width: balloonWelcomeLabel.contentWidth + 100
            sourceSize.height: 300

            Label {
                anchors.centerIn: parent

                width: 200
                height: parent.sourceSize.height - 20

                id: balloonWelcomeLabel
                text: "Привет! Я Deskchan v 0.0.1 Preview. Как мне к тебе обращаться?"
                textFormat: Text.AutoText
                lineHeight: 1.25
                verticalAlignment: Text.AlignVCenter
                font.family: "Anime Ace V02"
                font.weight: Font.Normal
                font.pointSize: 10
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
            }
                TextInput {
                    id:ballonUsernameInput
                    width: 120
                    height: 40
                    horizontalAlignment: TextInput.AlignHCenter
                    x: 70
                    y: 200

                    color: "orange"
                    text: "faggot"
                    font.family: "Anime Ace V02"
                    font.weight: Font.DemiBold
                    font.pointSize: 12

                    maximumLength: 9
                    validator: RegExpValidator { regExp: /^[a-zA-Zа-яА-Я-]*$/ }

                    onAccepted: {
                        console.log("set default user: ", text)
                        Talk.defaultUser = text
                        balloonWelcome.visible = false;
                        balloon.visible = true;
                        timer.running = true;
                    }
            }
        }

    Image {

        id: img;
        x: 0
        y: 0
        source: "assets/front.png";


        onXChanged: {
            if(imageMouseArea.drag.active){
                //console.log("img x = " + x);
            }
        }

        onYChanged: {
            if(imageMouseArea.drag.active){
                //console.log("img y = " + y);
            }
        }

        MouseArea {
            id: imageMouseArea;
            anchors.fill: parent;
            drag {
                minimumX: 10
                minimumY: 10
                maximumX: Screen.width - img.width - balloon.paintedWidth
                maximumY: Screen.height - img.height
                target: img;
                axis: Drag.XandYAxis
            }
            onClicked: {
                //Talk.reactOnAction();
                //Talk.getRandomPhrase();
            }
            onPressAndHold: {
                console.log("Enable zoom");
            }
        }
        Timer {
            id: timer
            interval: Math.round(Math.random() * (6000 - 2000)) + 2000;
            running: false;
            repeat: true;
            onTriggered: {
                //Время высказывания высчитывается по формуле: кол-во букв * кол-во секунд на букву + кол-во пробело
                interval = Math.round(Math.random() * (6000 - 2000)) + 2000;
                console.log("phrase interval is", interval);
                Talk.getRandomPhrase();
            }
        }
    }

    FileDialog {
        id: selectGirlDialog
        title: "Select your girl"
        folder: shortcuts.home
        nameFilters: [ "Image file (*.svg *.png)" ]
        onAccepted: {
            img.source = selectGirlDialog.fileUrl.toString()
            img.x = 0
            img.y = 0
            console.log("You chose: " + selectGirlDialog.fileUrls)
            close();
        }
        onRejected: {
            console.log("Canceled")
            close();
        }
    }

}
