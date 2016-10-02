import QtQuick 2.5
import QtQuick.Controls 1.2

Rectangle {

    property alias label: balloonLabel.text;
    property alias fontSize: balloonLabel.font.pointSize;
    property alias show: balloon.visible;
    property alias source: balloon.source;

    color: "transparent"
    width: 400;
    height: 400;

    Image {
        id: balloon

        anchors.fill: parent
        anchors.left: parent.left
        anchors.leftMargin: 60

        source: "assets/balloon_right_oriented.png"

        Label {
            anchors.centerIn: parent

            width: (parent.sourceSize.width - 40 > 100) ? parent.sourceSize.width : 100;
            height: parent.sourceSize.height - 60

            id: balloonLabel
            text: "Deskchan v.0.1 Preview \nDesigned and developed by Deskchan Project crew"
            textFormat: Text.AutoText
            lineHeight: 1.25
            verticalAlignment: Text.AlignVCenter
            font.family: "Anime Ace V02"
            font.weight: Font.Normal
            font.pointSize: (width > parent.width - 40 || height > parent.height - 40) ? 10 : 12;
            horizontalAlignment: Text.AlignHCenter
            wrapMode: (width <= parent.sourceSize.width - 40 || height <= parent.sourceSize.height - 40) ? Text.WordWrap : Text.WrapAnywhere;
        }

    }
}
