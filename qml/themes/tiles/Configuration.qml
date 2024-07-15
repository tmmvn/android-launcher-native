pragma Singleton
import QtQuick
import QtCore

Item {
    id: root

    property bool dark: true
    property color color: "green"

    Settings {
        property alias dark: root.dark
        property alias color: root.color
    }
}
