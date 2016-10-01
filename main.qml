import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.2
import QtQuick.Window 2.0

import "scripts/talk.js" as Talk

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
        width: 100;
        height: 100;

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

    /*Rectangle {
        id: balloon
        x: img.width + img.x
        y: img.y
        width: balloonLabel.width + 32
        height: balloonLabel.maximumLineCount * balloonLabel.font.pixelSize
        color: "white"

        radius: 20

        border.color: "black"
        border.width: 2

        Label {
            anchors.centerIn: parent
            id: balloonLabel
            text: "Панк - это дерзость\n и молодость мира! F.P.G"
            textFormat: Text.AutoText
            verticalAlignment: Text.AlignVCenter
            font.family: "Anime Ace V02"
            font.weight: Font.Normal
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            maximumLineCount: 12
        }
    }*/

    Image {
            id: balloon

            source: "assets/balloon_right_oriented.svg"

            x: img.width + img.x
            y: img.y
            sourceSize.width: balloonLabel.contentWidth + 32
            sourceSize.height: balloonLabel.contentHeight * balloonLabel.font.pixelSize

            Label {
                anchors.centerIn: parent
                id: balloonLabel
                text: "Панк - это дерзость \nи молодость мира! F.P.G"
                textFormat: Text.AutoText
                verticalAlignment: Text.AlignVCenter
                font.family: "Anime Ace V02"
                font.weight: Font.Normal
                font.pixelSize: 12
                horizontalAlignment: Text.AlignHCenter
                maximumLineCount: 12
                wrapMode: Text.Wrap
            }
        }

    Image {

        id: img;
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
                img.source = imageMouseArea.containsMouse && img.source == "assets/front.png" ? "assets/back.png" : "assets/front.png";
                Talk.reactOnAction();
            }
        }
    }

}
