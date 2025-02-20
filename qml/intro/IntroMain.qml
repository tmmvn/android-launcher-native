import QtQuick
import QtQuick.Controls
import com.iktwo.qutelauncher as QL

IntroScreen {

    Column {
        anchors {
            fill: parent
            margins: 8 * QL.ScreenValues.dp
        }

        Label {
            anchors {
                left: parent.left
                right: parent.right
            }

            text: qsTr("QuteLauncher")
            color: "#ffffff"
            horizontalAlignment: Text.AlignHCenter

            font.pointSize: 22
        }

        Item {
            height: 16 * QL.ScreenValues.dp
        }

        Label {
            anchors {
                left: parent.left
                right: parent.right
            }

            text: "**PLACEHOLDER** Customizable open source Android launcher. Get the source code and contribute at https://iktwo.github.io/QuteLauncher/"
            color: "#ffffff"
            horizontalAlignment: Text.AlignJustify
            wrapMode: Text.Wrap

            font.pointSize: 16
        }

        Item {
            height: 24 * QL.ScreenValues.dp
        }

        Image {
            anchors.horizontalCenter: parent.horizontalCenter

            width: Math.min(parent.width, parent.height) * 0.34
            height: width
            source: "qrc:/qt/qml/com/iktwo/qutelauncher/qml/resources/images/icon"
        }
    }
}
