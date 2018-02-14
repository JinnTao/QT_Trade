//import QtQuick 2.0
//Rectangle {
//    id:chosenItem
//    property string items: ""
//    property alias text: chosenItemText.text//test别名，用于在mian.qml中传入text
//    signal comboClicked;
//    width: 60;
//    height: 30;
//    smooth:true;
//    radius:4;
//    color: "aliceblue"
//    Text {
//      id:chosenItemText
//      anchors.centerIn: parent
//      anchors.verticalCenter: parent.verticalCenter
//      font.pointSize: 15
//      font.bold:true
//      fontSizeMode:Text.HorizontalFit
//      style: Text.Raised
//    }
//    MouseArea {
//        width: 60
//        height: 20
//        anchors.bottomMargin: 0
//        anchors.fill: parent;
//        onClicked: {
//               chosenItem.state = chosenItem.state==="dropDown"?"":"dropDown"
//        }
//    }
//    Rectangle {
//         id:dropDown
//         width:chosenItem.width;
//         height:0;
//         clip:true;
//         radius:4;
//         anchors.top: chosenItem.bottom;
//         anchors.margins: 2;
//         color: "aliceblue"
//         ListView {
//              id:listView
//              height:500;
//              model: chosenItem.items
//              currentIndex: 0
//              delegate: Item{
//                      width:chosenItem.width;
//                      height: chosenItem.height;
//                      Text {
//                          text: modelData
//                          anchors.top: parent.top;
//                          //anchors.left: parent.left;
//                          anchors.horizontalCenter:parent.horizontalCenter
//                          anchors.margins: 5;
//                      }
//                      MouseArea {
//                            anchors.fill: parent;
//                            onClicked: {
//                                    chosenItem.state = ""
//                                if(Item[0])
//                                    FILE_USER.on_actionNew_triggered();
//                                }
//                      }
//             }
//        }
//   }
//   states: State {
//            name: "dropDown";
//            PropertyChanges {
//                target: dropDown; height:30*chosenItem.items.length
//            }
//   }
//   transitions: Transition {
//                    NumberAnimation { target: dropDown; properties: "height"; easing.type: Easing.OutExpo; duration: 1000 }
//   }
//}
