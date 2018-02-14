//import QtQuick 2.4
//import QtQuick.Layouts 1.1
//import QtQuick.Window 2.2
//import QtQuick.Controls 1.3
//import Material 0.2
//import Material.ListItems 0.1 as ListItem

//Item {
//    id: loginDialog
//    anchors.fill: parent
//    // Add a simple animation to fade in the popup
//    // let the opacity go from 0 to 1 in 400ms
//    property int testData: 0
//    property QtObject appRoot: Null
//    //parent: appRoot
//    PropertyAnimation { target: loginDialog; property: "opacity";
//        duration: 400; from: 0; to: 1;
//        easing.type: Easing.InOutQuad ; running: true }

//    // This rectange is the a overlay to partially show the parent through it
//    // and clicking outside of the 'dialog' popup will do 'nothing'
//    Rectangle {
//        anchors.fill: parent
//        id: overlay
//        color: "#000000"
//        opacity: 0.6
//        // add a mouse area so that clicks outside
//        // the dialog window will not do anything
//        MouseArea {
//            anchors.fill: parent
//            onClicked: {
//                console.log(testData);
//                console.log(parent.data.objectName)
//                console.log(parent.contains())
//            }
//        }
//    }
//    View {
//        anchors.centerIn: parent
//        width: Units.dp(400)
//        height: column.implicitHeight + Units.dp(32)

//        elevation: 1
//        radius: Units.dp(2)
//        //visible: false;

//        ColumnLayout {
//            id: column

//            anchors {
//                fill: parent
//                topMargin: Units.dp(16)
//                bottomMargin: Units.dp(16)
//            }

//            Label {
//                id: titleLabel

//                anchors {
//                    left: parent.left
//                    right: parent.right
//                    margins: Units.dp(16)
//                }

//                style: "title"
//                text: qsTr("Account Login")
//            }

//            Item {
//                Layout.fillWidth: true
//                Layout.preferredHeight: Units.dp(8)
//            }
//            ListItem.Standard {
//                action: Icon {
//                    anchors.centerIn: parent
//                    name: "maps/place"
//                }

//                content: TextField {
//                    //anchors.centerIn: parent
//                    width: parent.width
//                    placeholderText: "Broker Id"
//                }
//            }
//            ListItem.Standard {
//                action: Icon {
//                    anchors.centerIn: parent
//                    name: "action/account_circle"
//                }

//                content: TextField {
//                    anchors.centerIn: parent
//                    width: parent.width
//                    placeholderText:"User Id"
////                    text: "Alex Nelson"
//                }
//            }
//            ListItem.Standard {
//                action: Icon {
//                    anchors.centerIn: parent
//                    name: "action/account_circle"
//                }

//                content: TextField {
//                    anchors.centerIn: parent
//                    width: parent.width
//                    placeholderText:"password"
////                    text: "Alex Nelson"
//                }
//            }

//            ListItem.Standard {
//                action: Icon {
//                    anchors.centerIn: parent
//                    name: "action/account_circle"
//                }

//                content: TextField {
//                    anchors.centerIn: parent
//                    width: parent.width
//                    placeholderText:"Md Address"
////                    text: "Alex Nelson"
//                }
//            }

//            ListItem.Standard {
//                action: Icon {
//                    anchors.centerIn: parent
//                    name: "action/account_circle"
//                }

//                content: TextField {
//                    anchors.centerIn: parent
//                    width: parent.width
//                    placeholderText:"Td Address"
////                    text: "Alex Nelson"
//                }
//            }

//            ListItem.Standard {
//                action: Item {}
//                //parent: parent.childAt(parent.x,parent.y)
//                content: RowLayout {
//                    anchors.centerIn: parent
//                    width: parent.width

//                    TextField {
//                        Layout.alignment: Qt.AlignVCenter
//                        Layout.preferredWidth: 0.4 * parent.width

//                        text: "New York"
//                    }

//                    MenuField {
//                        //parent: loginDialog
//                        Layout.alignment: Qt.AlignVCenter
//                        Layout.preferredWidth: 0.2 * parent.width

//                        model: ["NY", "NC", "ND"]
//                    }

//                    TextField {
//                        Layout.alignment: Qt.AlignVCenter
//                        Layout.preferredWidth: 0.3 * parent.width

//                        text: "10011"
//                    }
//                }
//            }
//            Item {
//                Layout.fillWidth: true
//                Layout.preferredHeight: Units.dp(8)
//            }

//            RowLayout {
//                Layout.alignment: Qt.AlignRight
//                spacing: Units.dp(8)

//                anchors {
//                    right: parent.right
//                    margins: Units.dp(16)
//                }

//                Button {
//                    text: "Cancel"
//                    textColor: Theme.primaryColor
//                    onClicked: {
//                        console.log(parent.data.objectName)
//                        loginDialog.destroy()
//                    }
//                }

//                Button {
//                    text: "Done"
//                    textColor: Theme.primaryColor
//                    onClicked: {
//                         loginDialog.destroy()
//                    }
//                }
//            }
//        }
//    }






//}
