import QtQuick 2.5

Rectangle {

    property int offset
    property int size
    property alias image: img.source

    signal fabClicked();

    z: 100;
    width: size;
    height: size;

    color: "transparent"

    Image {
        id: img
        source: src
        width: parent.width
        height: parent.height
    }

    MouseArea {
        id: area;
        width: parent.width
        height: parent.height
        anchors.fill: parent;
        cursorShape: Qt.PointingHandCursor
        onClicked: fabClicked();
    }

}

