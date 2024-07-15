import QtQuick
import QtQuick.Controls.Basic
import com.iktwo.qutelauncher as QL

RadioButton {
    contentItem: Text {
        text: control.text
        color: "#ffffff"
    }

    indicator: Rectangle {
        implicitWidth: QL.ScreenValues.dp * 16
        implicitHeight: QL.ScreenValues.dp * 16
        radius: QL.ScreenValues.dp * 9
        border {
            color: control.activeFocus ? "darkblue" : "gray"
            width: QL.ScreenValues.dp * 1
        }

        Rectangle {
            anchors {
                fill: parent
                margins: QL.ScreenValues.dp * 4
            }

            visible: control.checked
            color: "#555"
            radius: QL.ScreenValues.dp * 9
        }
    }
}
