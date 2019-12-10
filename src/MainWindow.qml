import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1
import QtQuick.Window 2.0


ApplicationWindow
{
id: appWindow
width: 400
height: 600
visible: true

Page{
id: unitConvertPage;
    anchors.fill: parent
      header:  Label {
padding: 10;
text: qsTr("Unit Convert");
      font.pixelSize:20;
horizontalAlignment: Text.AlignHCenter;
verticalAlignment: Text.AlignVCenter;
      }
    function convert(){
      answer.text = backend.convert(quantityField.text, unitField.text)

    }

    ColumnLayout {
      anchors.fill:parent
    GridLayout {

        anchors.margins:10
        columns:2


        Label {
text: "Quantity:"
        font.pointSize:12
        Layout.alignment: Qt.AlignRight
        }
      TextField{
id: quantityField
      Layout.fillWidth: true
      }



      Label {
text: "Unit:"
        font.pointSize:12
        Layout.alignment: Qt.AlignRight
      }
      TextField{
id: unitField
      Layout.fillWidth: true
      Keys.onReleased: unitConvertPage.convert()
      }


      Label {
        text: "Answer:"
        font.pointSize:12
        Layout.alignment: Qt.AlignRight
      }
      Label {
        id: answer
        Layout.fillWidth: true
      }
    }



      Button
      {
        id: saveButton;
        text: "Save";
        Layout.fillWidth: true
        function save(){
        var q = quantityField.text
        var a = answer.text
        var e = q + " = " + a
        conversionsListModel.append({"conversion":e})
        }
        onPressed: save()
        Keys.onReturnPressed:  save()
        Keys.onEnterPressed: save()
      }
      Button
      {
        id: loadButton;
        text: "Load";
        Layout.fillWidth: true
        function load(){
        var i = conversionsListView.currentIndex
        var e = conversionsListModel.get(i).conversion
        var q = e.substr(0,e.indexOf('=')).trim()
        var u = e.substr(e.indexOf('=')+1).trim()
        u = u.substr(u.indexOf(' ')+1).trim()

        quantityField.text = q
        unitField.text = u
        unitConvertPage.convert()
        }
        onPressed: load()
        Keys.onReturnPressed:  load()
        Keys.onEnterPressed: load()
      }
      Button
      {
        id: swapButton;
        text: "Swap";
        Layout.fillWidth: true
        function run(){ var q = quantityField.text
        var u = unitField.text
        quantityField.text = answer.text
        unitField.text = q.substr(q.indexOf(' ')+1)
        unitConvertPage.convert()}
        onPressed: run()
        Keys.onReturnPressed:  run()
        Keys.onEnterPressed: run()
      }
      Button
      {
        id: baseUnitsButton;
        text: "Base Units";
        Layout.fillWidth: true
        function run(){
        unitField.text = "base units"
        unitConvertPage.convert()
        }
        onPressed: run()
        Keys.onReturnPressed:  run()
        Keys.onEnterPressed: run()
      }




      ListModel {
        id: conversionsListModel
      }
      Tumbler
      {
      id: conversionsListView
      visibleItemCount:10
       model: conversionsListModel
        Layout.fillWidth: true
        Layout.fillHeight: true
      }


}


}
}
