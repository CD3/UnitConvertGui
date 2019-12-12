import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1

Page {
  anchors.fill: parent

  header : TabBar
  {
    id: tabBar
    width:parent.width
    currentIndex : 0
    TabButton{
      text: qsTr("Convert")
    }
    //TabButton{
      //text: qsTr("Definitions")
      //}
    }

    SwipeView
    {
      id: pageViewer
      anchors.fill: parent
      currentIndex : tabBar.currentIndex
      Page{
        id: unitConvertPage
        padding: 10
        header:  Label
        {
          padding: 10;
          text: qsTr("Unit Convertions");
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
              text: qsTr("Quantity:")
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
              Component.onCompleted: quantityField.forceActiveFocus()

            }


            Label
            {
              text: qsTr("Unit:")
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
              text: qsTr("Answer:")
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
            text: qsTr("Save")
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
            id: removeButton;
            text: qsTr("Remove")
            Layout.fillWidth: true
            function run(){
              if( conversionsListModel.count > 0 )
              {
                conversionsListModel.remove(conversionsListView.currentIndex)
              }
            }
            onPressed: run()
            Keys.onReturnPressed:  run()
            Keys.onEnterPressed: run()
          }
          Button
          {
            id: loadButton;
            text: qsTr("Load")
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
            text: qsTr("Swap")
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
            text: qsTr("Convert to Base Units")
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
            TextField
            {
              id: addUnitField
              Layout.fillWidth: true
              placeholderText: "254 cm = 100 in"
            }
            Button
            {
              id: addUnitsButton;
              text: qsTr("Add Unit")
              Layout.fillWidth: false
              function run(){
                backend.addUnit(addUnitField.text)
                addUnitField.text = ""
              }
              onPressed: run()
              Keys.onReturnPressed:  run()
              Keys.onEnterPressed: run()
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


        }

        footer: Label
        {
          id: msgLabel
          text: ""
        }

      }
      //Page{
        //id: unitDefinitionsPage
        //visible:false
        //ColumnLayout{
          //anchors.fill: parent

          //TextArea
          //{
            //id: unitDefinitionsText
            //Layout.fillWidth: true
            //Layout.fillHeight: true
            //}
            //Button
            //{
              //id: saveDefinitionsButton;
              //text: qsTr("Save")
              //Layout.fillWidth: true
              //function run(){
                //}
                //onPressed: run()
                //Keys.onReturnPressed:  run()
                //Keys.onEnterPressed: run()
                //}

                //}
                //}
              }
            }

