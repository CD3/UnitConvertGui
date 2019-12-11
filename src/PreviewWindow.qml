import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1
import QtQuick.Window 2.0


Window {
    visible: true
    title: qsTr("Preview")
    property var qmlFile: "MainWindowContent.qml"

    Loader {
        id: _loader
        anchors.fill: parent

        function reload() {
            source = "";
            QmlEngine.clearCache();
            source = qmlFile;
        }

        anchors.centerIn: parent
        source: qmlFile
    }

    Timer {
      interval: 1000
      running: true
      repeat: true
      onTriggered: {_loader.reload()}

    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            _loader.reload();
        }
        onPressed: {
            _loader.reload();
        }
    }
}
