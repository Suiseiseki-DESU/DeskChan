import QtQuick 2.5

Item {

    property int offset
    property int size
    property alias image: img.source
    x: img.x - offset;
    y: img.y - offset;
    z: 100;
    width: size;
    height: size;

    Image {
        id: img
        source: src
    }


}
