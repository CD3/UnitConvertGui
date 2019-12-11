import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1

Page
{
  id: unitConvertPage;
  anchors.fill: parent
  header:  Label
  {
    padding: 10;
    text: qsTr("Unit Convert");
    font.pixelSize:20;
    horizontalAlignment: Text.AlignHCenter;
    verticalAlignment: Text.AlignVCenter;
  }

  function convert(){
    answer.text = backend.convert(quantityField.text, unitField.text)
  }

  ColumnLayout
  {
    anchors.fill:parent
    GridLayout
    {
      anchors.margins:10
      columns:2

      Label
      {
        text: "Quantity:"
        font.pointSize:12
        Layout.alignment: Qt.AlignRight
      }
      TextField
      {
        id: quantityField
        Layout.fillWidth: true
        placeholderText: "10 m"
        ToolTip.text: qsTr("The quantity you want to convert.")
        ToolTip.visible: hovered
        ToolTip.delay: 1000
      }


      Label
      {
        text: "Unit:"
        font.pointSize:12
        Layout.alignment: Qt.AlignRight
      }
      TextField
      {
        id: unitField
        Layout.fillWidth: true
        Keys.onReleased: unitConvertPage.convert()
        placeholderText: "in"
        ToolTip.text: qsTr("The unit you want to convert too.")
        ToolTip.visible: hovered
        ToolTip.delay: 1000
      }


      Label
      {
        text: "Answer:"
        font.pointSize:12
        Layout.alignment: Qt.AlignRight
      }
      Label
      {
        id: answer
        Layout.fillWidth: true
      }
    }



    Button
    {
      id: saveButton;
      text: "Save";
      Layout.fillWidth: true
      function run(){
        var q = quantityField.text
        var a = answer.text
        var e = q + " = " + a
        conversionsListModel.append({"conversion":e})
      }
      onPressed: run()
      Keys.onReturnPressed:  run()
      Keys.onEnterPressed: run()
    }
    Button
    {
      id: loadButton;
      text: "Load";
      Layout.fillWidth: true
      function run(){
        var i = conversionsListView.currentIndex
        var e = conversionsListModel.get(i).conversion
        var q = e.substr(0,e.indexOf('=')).trim()
        var u = e.substr(e.indexOf('=')+1).trim()
        u = u.substr(u.indexOf(' ')+1).trim()

        quantityField.text = q
        unitField.text = u
        unitConvertPage.convert()
      }
      onPressed: run()
      Keys.onReturnPressed:  run()
      Keys.onEnterPressed: run()
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

    RowLayout
    {
      anchors.margins:10
      Button
      {
        id: addUnitsButton;
        text: "Add Unit";
        Layout.fillWidth: false
        function run(){
          backend.addUnit(addUnitField.text)
          addUnitField.text = ""
        }
        onPressed: run()
        Keys.onReturnPressed:  run()
        Keys.onEnterPressed: run()
      }
      TextField
      {
        id: addUnitField
        Layout.fillWidth: true
        placeholderText: "254 cm = 100 in"
      }
    }



    ListModel
    {
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


    Label
    {
      id: msgLabel
      text: ""
    }
  }


}