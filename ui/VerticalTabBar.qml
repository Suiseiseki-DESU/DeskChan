import QtQuick 2.5

Rectangle {
    width: 128
    height: 140
    gradient: Gradient {
        GradientStop {
            position: 0.0
            color: "red"
        }
        GradientStop {
            position: 1.0
            color: "green"
        }
    }
    Text {
        anchors.centerIn: parent
        text: "lorem"
    }
}
