import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.0
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.2
import QtQuick.Window 2.0
import QtGraphicalEffects 1.0

import "scripts/talk.js" as Talk
import "scripts/controller.js" as Controller

import "ui/Balloon"
import "ui/BalloonInput"
import "ui/DeskButton"

ApplicationWindow {
    id: window

    property int offset: 25
    property variant handle
    visible: true
    width: Screen.width
    height: Screen.height
    onClosing: Qt.quit();
    modality: "NonModal";
    flags: Qt.ToolTip | Qt.FramelessWindowHint | Qt.WA_TranslucentBackground | Qt.WindowStaysOnTopHint | Qt.BypassGraphicsProxyWidget | Qt.SubWindow
    color: "transparent"

    DeskButton {
        id: exitButton
        x: deskchanImage.x - offset;
        y: deskchanImage.y;
        image: "assets/close.png"
        size: 60

        onFabClicked: Qt.quit();
    }

    DeskButton {
        id: uploadButton
        x: deskchanImage.x - offset;
        y: deskchanImage.y + height + offset;
        image: "assets/upload.png"
        size: 60

        onFabClicked: selectGirlDialog.open();
    }

    DeskButton {
        id: settingsButton
        x: deskchanImage.x - offset;
        y: deskchanImage.y + (height + offset) * 2;
        image: "assets/settings.png"
        size: 60

        onFabClicked: {
            var component = Qt.createComponent("BalloonForm.qml");
            handle = component.createObject(window);
            handle.show();
        }
    }


    Image {
        id: deskchanImage;

        source: "assets/front.png";
        transformOrigin: Image.Center;
        cache: false;

        MouseArea {
            id: imageMouseArea;
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.OpenHandCursor
            drag {
                minimumX: 10
                minimumY: 10
                maximumX: Screen.width - deskchanImage.width - balloon.paintedWidth
                maximumY: Screen.height - deskchanImage.height
                target: deskchanImage;
                axis: Drag.XAndYAxis
            }
            onClicked: {
                parent.state == "front" ? parent.state = "back" : parent.state = "front";
            }
            onPressed: {
                imageMouseArea.cursorShape = Qt.ClosedHandCursor;
            }
            onReleased: {
                imageMouseArea.cursorShape = Qt.OpenHandCursor;
            }
            onPressAndHold: {
                console.log("Enable zoom");
            }
            onWheel: {
                var scaleFactor = 0.00025;
                if (wheel.modifiers && Qt.ControlModifier) {
                    //wheel up
                    if(wheel.angleDelta.y > 0) {
                        console.log("scale wheel up: ", wheel.angleDelta);
                        deskchanImage.width = wheel.angleDelta.y * scaleFactor;
                        deskchanImage.height = wheel.angleDelta.y * scaleFactor;
                    }
                    //wheel down
                    if(wheel.angleDelta.y < 0) {
                        deskchanImage.width = wheel.angleDelta.y / scaleFactor;
                        deskchanImage.height = wheel.angleDelta.y / scaleFactor;
                        console.log("scale wheel down: ", wheel.angleDelta);
                    }
                }
            }
        }

        states: [
            State {
                name: "front";
                PropertyChanges {
                    target: deskchanImage;
                    source: "assets/front.png";
                }
            },
            State {
                name: "back";
                PropertyChanges {
                    target: deskchanImage;
                    source: "assets/back.png";
                }
            },
            State {
                name: "default";
                PropertyChanges {
                    target: deskchanImage;
                    source: source;
                }
            }
        ]
    }

    Balloon {
        id: balloon
        show: false;
        x: deskchanImage.width - 150 + deskchanImage.x
        y: 10

        label: "Deskchan v.0.1 Preview \nDesigned and developed by Deskchan Project crew."
    }

    BalloonInput {
        id: balloonWelcome
        x: deskchanImage.width - 150 + deskchanImage.x
        y: 10

        label: "Привет! Я Deskchan v 0.0.1 Preview. Как мне к тебе обращаться?"
        onBalloonInputAccepted: Controller.welcomeInputAccepted();

    }

    Timer {
        id: timer
        interval: Math.round(Math.random() * (6000 - 2000)) + 2000;
        running: false;
        repeat: true;
        onTriggered: {
            interval = Math.round(Math.random() * (6000 - 2000)) + 2000;
            console.log("phrase interval is", interval);
            Talk.getRandomPhrase();
        }
    }

    FileDialog {
        id: selectGirlDialog
        title: "Select your girl"
        folder: shortcuts.home
        nameFilters: [ "Image file (*.svg *.png)" ]
        onAccepted: {
            deskchanImage.source = selectGirlDialog.fileUrl.toString();
            console.log("You chose: " + selectGirlDialog.fileUrls);
            close();
        }
        onRejected: {
            console.log("Canceled")
            close();
        }
    }
}
