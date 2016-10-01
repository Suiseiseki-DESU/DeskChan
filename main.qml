import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.2
import QtQuick.Window 2.0

import "scripts/talk.js" as Talk

ApplicationWindow {
    id: root

    x: 100;
    y: 100;

    visible: true
    width: img.width
    height: img.height
    title: "lorm"
    onClosing: Qt.quit();

    flags: Qt.ToolTip | Qt.FramelessWindowHint | Qt.WA_TranslucentBackground | Qt.WindowStaysOnTopHint
    color: "transparent"

    Rectangle {
        id: exitButton
        x: 10;
        y: 10;
        width: 50;
        height: 50;
        color: "#ff0000";
        radius: 50;

        MouseArea {
            width: exitButton.width
            height: exitButton.height
            anchors.fill: parent;
            onClicked: {
                console.log("on exit circle clicked");
                Qt.quit();
            }
        }
    }

    Rectangle {
        id: balloon
        x: 300
        y: 10
        width: 100
        height: 100
        color: "white"

        radius: 20

        border.color: "black"
        border.width: 2

        Label {
            anchors.centerIn: parent
            id: balloonLabel
            text: "hello"
            font.family: "Arial"
            font.pixelSize: 12
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
                move();
                Talk.reactOnAction();
            }
            function move()
            {
                var front  = "/assets/front.png";
                var back = "/assets/back.png";
                img.source = ((img.source == front) ? back : front);
            }
        }
    }

}
