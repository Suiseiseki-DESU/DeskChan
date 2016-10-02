import QtQuick 2.4
import QtQuick.Window 2.0

import "ui/Balloon"

Window {
    width: 300
    height: 300
    title: "balloon"
    color: "transparent"
    flags: Qt.FramelessWindowHint

    Balloon {
        id: balloon
        anchors.fill: parent
        source: "ui/Balloon/assets/balloon_squared.svg"
        label: "Здесь может быть ваша реклама"
    }

}
