//import QtQuick
import com.iktwo.qutelauncher as QL
import "../../components" as C

C.PressAndHoldMenu {
    property string packageName
    property string name

    expandedHeight: menuItem.height * 2

    C.MenuItem {
        id: menuItem
        text: qsTr("Info")
        onClicked: QL.PackageManager.openApplicationInfo(packageName)
    }

    C.MenuItem {
        /// TODO: consume the click even if not enabled
        /// TODO: verify this
        // enabled: QL.PackageManager.packages.indexOf(packageName) === -1
        text: qsTr("Add to grid")

        onClicked: QL.PackageManager.addApplicationToGrid(name, packageName)
    }
}
