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

    x: Screen.width - img.width - 10;
    y: Screen.height;

    visible: true
    width: Screen.width
    height: Screen.height
    title: "lorm"
    onClosing: Qt.quit();

    flags: Qt.ToolTip | Qt.FramelessWindowHint | Qt.WA_TranslucentBackground | Qt.WindowStaysOnTopHint
    color: "transparent"

    Image {
        id: exitButton
        x: img.x - 10;
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
        x: img.x - 10;
        y: img.y + height + 10;
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

            source: "assets/balloon_right_oriented.svg"

            x: img.width + img.x
            y: img.y

            sourceSize.width: balloonLabel.contentWidth + 50
            sourceSize.height: 200

            Label {
                anchors.centerIn: parent

                width: 200
                height: parent.sourceSize.height - 20

                id: balloonLabel
                text: "Панк - это дерзость \nи молодость мира! F.P.G"
                textFormat: Text.AutoText
                verticalAlignment: Text.AlignVCenter
                font.family: "Anime Ace V02"
                font.weight: Font.Normal
                font.pixelSize: 12
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
            }

        }

    Image {

        id: img;
        x: 0
        y: 0
        source: "assets/front.png";


        onXChanged: {
            if(imageMouseArea.drag.active){
                console.log("img x = " + x);
            }
        }

        onYChanged: {
            if(imageMouseArea.drag.active){
                console.log("img y = " + y);
            }
        }

        MouseArea {
            id: imageMouseArea;
            anchors.fill: parent;
            drag {
                target: img;
                axis: Drag.XandYAxis
            }
            onClicked: {
                //Talk.reactOnAction();
                Talk.getRandomPhrase();
            }
            onPressAndHold: {
                console.log("Enable zoom");
            }
        }
        Timer {
            interval: Math.random() * 10000;
            running: true;
            repeat: true;
            onTriggered: Talk.getRandomPhrase();
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
