import QtQuick
import QtQuick.Controls
//import QtQuick.Layouts
import com.iktwo.qutelauncher as QL
import "../../config" as Config

ScrollView {
    id: root

    property alias model: gridView.model

    signal pressAndHold(var model, int x, int y)

    anchors.fill: parent


    //ScrollBar.transientScrollBars: false

    //ScrollBar.scrollBarBackground: Rectangle {
    //    implicitWidth: 5 * QL.ScreenValues.dp

    //    color: "#d9d9d9"
    //}

    //ScrollBar.handle: Rectangle {
    //    implicitWidth: 5 * QL.ScreenValues.dp

    //    color: "#129688"
    //}

    //ScrollBar.corner: Item { }
    //ScrollBar.decrementControl: Item { }
    //ScrollBar.incrementControl: Item { }

    GridView {
        id: gridView
        focus: true

        property int highlightedItem

        maximumFlickVelocity: height * 5

        header: Item {
            width: parent.width
            height: 20 * QL.ScreenValues.dp
        }

        add: Transition {
            NumberAnimation { properties: "opacity"; from: 0; to: 1; duration: 450 }
            NumberAnimation { property: "scale"; from: 0; to: 1.0; duration: 500 }
        }

        //displaced: Transition {
        //    NumberAnimation { property: "opacity"; to: 1.0 }
        //    NumberAnimation { property: "scale"; to: 1.0 }
        //}

        clip: true
        interactive: visible

        cellHeight: height / Config.Theme.getColumns()
        cellWidth: width / Config.Theme.getRows()

        delegate: ApplicationTile {
            id: applicationTile

            height: GridView.view.cellHeight
            width: GridView.view.cellWidth

            source: "image://icon/" + model.packageName
            text: model.name

            onClicked: QL.PackageManager.launchApplication(model.packageName)
            onPressAndHold: root.pressAndHold(model, x, y)
        }

        onHeightChanged: {
            if (height !== 0)
                cacheBuffer = Math.max(1080, height * 5)
        }
    }
}
