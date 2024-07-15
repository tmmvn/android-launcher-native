import QtQuick
import QtQuick.Controls
import QtCore
//import com.iktwo.qutelauncher 1.0 as QL
//import components 1.0 as C
import "../config" as Config

IntroScreen {
    Column {
        anchors.centerIn: parent

        Repeater {
            id: repeater

            model: ["Classic", "Tiles"]

            RadioButton {
                text: modelData
                checked: index === 0

                ButtonGroup.group: exclusiveGroupTheme
            }
        }
    }

    Settings {
        id: settings

        property string theme: repeater.model[0].toLowerCase()
    }

    ButtonGroup {
        id: exclusiveGroupTheme
    }

    onNext: Config.Theme.theme = exclusiveGroupTheme.current.text.toLowerCase()
}
