/*
 * author qyvlik
 * email qyvlik@qq.com
 * time 2015/4/10
*/

import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Window 2.2
import QtQuick.Controls 1.3
import Material 0.2
import Material.ListItems 0.1 as ListItem

ApplicationWindow {
    id: demo

    title: "Deritive Trading"

    // Necessary when loading the window from C++
    visible: true

    theme {
        primaryColor: "blue"
        accentColor: "red"
        tabHighlightColor: "white"
    }

    property var styles: [
            "Icons", "Custom Icons", "Color Palette", "Typography"
    ]

    property var basicComponents: [
            "Button", "CheckBox", "Progress Bar", "Radio Button",
            "Slider", "Switch", "TextField"
    ]

    property var compoundComponents: [
            "Bottom Sheet", "Dialog", "Forms", "List Items", "Page Stack", "Time Picker", "Date Picker"
    ]

    property var sections: [ basicComponents, styles, compoundComponents ]

    property var sectionTitles: [ "衍生品交易", "Style", "Compound Components" ]

    property string selectedComponent: sections[0][0]

    initialPage: TabbedPage {
        id: page
        //parent: demo
        title: "Auto Trade"

        actionBar.maxActionCount:navDrawer.enabled ? 7 :8
        actions: [
            Action {
                iconName: "alert/warning"
                name: "Dummy error";
                onTriggered: {
                    demo.showError("Something went wrong", "Do you want to retry?", "Close", true)
                }
            },

            Action {
                iconName: "image/color_lens"
                name: "Colors"
                onTriggered: colorPicker.show()
            },

            Action {
                iconName: "action/settings"
                name: "Settings"
                hoverAnimation: true
            },

            Action {
                iconName: "alert/warning"
                name: "THIS SHOULD BE HIDDEN!"
                visible: false
            },

            Action {
                iconName: "action/language"
                name: "Language"
                //enabled: false
            },

            Action {
                iconName: "action/account_circle"
                name: "Accounts"
                onTriggered: {
                    loginDialog.show();
                    //accountLoginDialog.visible = true;
                    //Qt.createComponent("LoginDialog.qml").createObject(demo,{"appRoot":demo.data,"testData":123})
                }
            }
        ]

        backAction: navDrawer.action
        // 小窗口显示状态
        NavigationDrawer {
            id: navDrawer

            enabled: page.width < Units.dp(500)

            onEnabledChanged: smallLoader.active = enabled

            Flickable {
                anchors.fill: parent

                contentHeight: Math.max(content.implicitHeight, height)

                Column {
                    id: content
                    anchors.fill: parent

                    Repeater {
                        model: sections

                        delegate: Column {
                            width: parent.width

                            ListItem.Subheader {
                                            text:sectionTitles[index]
                                }


                            Repeater {
                                model: {
                                    modelData
                                }
                                delegate: ListItem.Standard {
                                    text:{
                                        modelData
                                    }
                                    selected: modelData == demo.selectedComponent
                                    onClicked: {
                                        demo.selectedComponent = modelData
                                        navDrawer.close()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        Repeater {
            model: !navDrawer.enabled ? sections : 0

            delegate: Tab {
                title:{

                  return sectionTitles[index]
                }

                property string selectedComponent: modelData[0]
                property var section: modelData

                sourceComponent: tabDelegate
            }
        }

        Loader {
            id: smallLoader
            anchors.fill: parent
            sourceComponent: tabDelegate

            property var section: []
            visible: active
            active: false
        }
    }

    Dialog {
        id: colorPicker
        title: "Pick color"

        positiveButtonText: "Done"

        MenuField {
            id: selection
            model: ["Primary color", "Accent color", "Background color"]
            width: Units.dp(160)
        }

        Grid {
            columns: 7
            spacing: Units.dp(8)

            Repeater {
                model: [
                    "red", "pink", "purple", "deepPurple", "indigo",
                    "blue", "lightBlue", "cyan", "teal", "green",
                    "lightGreen", "lime", "yellow", "amber", "orange",
                    "deepOrange", "grey", "blueGrey", "brown", "black",
                    "white"
                ]

                Rectangle {
                    width: Units.dp(30)
                    height: Units.dp(30)
                    radius: Units.dp(2)
                    color: Palette.colors[modelData]["500"]
                    border.width: modelData === "white" ? Units.dp(2) : 0
                    border.color: Theme.alpha("#000", 0.26)

                    Ink {
                        anchors.fill: parent

                        onPressed: {
                            switch(selection.selectedIndex) {
                                case 0:
                                    theme.primaryColor = parent.color
                                    break;
                                case 1:
                                    theme.accentColor = parent.color
                                    break;
                                case 2:
                                    theme.backgroundColor = parent.color
                                    break;
                            }
                        }
                    }
                }
            }
        }

        onRejected: {
            // TODO set default colors again but we currently don't know what that is
        }
    }

    Component {
        id: tabDelegate

        Item {

            Sidebar {
                id: sidebar

                expanded: !navDrawer.enabled

                Column {
                    width: parent.width

                    Repeater {
                        model: section
                        delegate: ListItem.Standard {
                            text: modelData
                            selected: modelData == selectedComponent
                            onClicked: selectedComponent = modelData
                        }
                    }
                }
            }
            Flickable {
                id: flickable
                anchors {
                    left: sidebar.right
                    right: parent.right
                    top: parent.top
                    bottom: parent.bottom
                }
                clip: true
                contentHeight: Math.max(example.implicitHeight + 40, height)
                Loader {
                    id: example
                    anchors.fill: parent
                    asynchronous: true
                    visible: status == Loader.Ready
                    // selectedComponent will always be valid, as it defaults to the first component
                    source: {
                        if (navDrawer.enabled) {

                            //console.log( Qt.resolvedUrl("%1Demo.qml").arg(demo.selectedComponent.replace(" ", "")))
                            return Qt.resolvedUrl("%1Demo.qml").arg(demo.selectedComponent.replace(" ", ""))
                        } else {
                            return Qt.resolvedUrl("%1Demo.qml").arg(demo.selectedComponent.replace(" ", ""))
                        }
                    }
                }

                ProgressCircle {
                    anchors.centerIn: parent
                    visible: example.status == Loader.Loading
                }
            }
            Scrollbar {
                flickableItem: flickable
            }
        }
    }


    Dialog {
        id:loginDialog
        positiveButtonText: "Login"
        title: "Account Login"

        ColumnLayout {
            id: column
            width: Units.dp(500)

            ListItem.Standard {
                action: Icon {
                    anchors.centerIn: parent
                    name: "maps/place"
                }

                content: TextField {
                    anchors.centerIn: parent
                    width: parent.width
                    placeholderText: "Broker Id"
                }
            }
            ListItem.Standard {
                action: Icon {
                    anchors.centerIn: parent
                    name: "action/account_circle"
                }

                content: TextField {
                    anchors.centerIn: parent
                    width: parent.width
                    placeholderText:"User Id"
//                    text: "Alex Nelson"
                }
            }
            ListItem.Standard {
                action: Icon {
                    anchors.centerIn: parent
                    name: "action/account_circle"
                }

                content: TextField {
                    anchors.centerIn: parent
                    width: parent.width
                    placeholderText:"password"
//                    text: "Alex Nelson"
                }
            }

            ListItem.Standard {
                action: Icon {
                    anchors.centerIn: parent
                    name: "action/account_circle"
                }

                content: TextField {
                    anchors.centerIn: parent
                    width: parent.width
                    placeholderText:"Md Address"
//                    text: "Alex Nelson"
                }
            }

            ListItem.Standard {
                action: Icon {
                    anchors.centerIn: parent
                    name: "action/account_circle"
                }

                content: TextField {
                    anchors.centerIn: parent
                    width: parent.width
                    placeholderText:"Td Address"
//                    text: "Alex Nelson"
                }
            }

            ListItem.Standard {
                action: Item {}
                content: RowLayout {
                    anchors.centerIn: parent
                    width: parent.width

                    TextField {
                        Layout.alignment: Qt.AlignVCenter
                        Layout.preferredWidth: 0.4 * parent.width
                        text: "New York"
                    }

                    MenuField {
                        Layout.alignment: Qt.AlignVCenter
                        Layout.preferredWidth: 0.2 * parent.width

                        model: ["NY", "NC", "ND"]
                    }

                    TextField {
                        Layout.alignment: Qt.AlignVCenter
                        Layout.preferredWidth: 0.3 * parent.width

                        text: "10011"
                    }
                }
            }
        }

    }

 }



        //visible: false;
//        View {
//            anchors.centerIn: parent

////            width: Units.dp(350)
////            height: column.implicitHeight + Units.dp(32)

//            elevation: 1
//            radius: Units.dp(2)
//        }



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
//            }/*
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
//                        loginDialog.visible = false;
//                    }
//                }

//                Button {
//                    text: "Done"
//                    textColor: Theme.primaryColor
//                    onClicked: {
//                         loginDialog.visible = false;
//                    }
//                }
//            }
//        }
//    }






//FlatMainWindow {
//    id:window;
//    objectName:"MainWindow"
//    title: qsTr("Flat Example Demo")
//    width: 960
//    height: 540
//    visible:true

////    menuBar: MenuBar{
////        Menu{
////            title:"title"
////        }
////    }

//    contentControl.anchors.margins: 20
//    content: Flow{
//        id:flow
//        spacing: 10

//            FlatButton{
//                text:"danger"
//                type:FlatGlobal.typeDanger
//            }
//            FlatButton{
//                text:"default"
//                type:FlatGlobal.typeDefault
//            }
//            FlatButton{
//                text:"disabled"
//                type:FlatGlobal.typeDisabled
//            }
//            FlatButton{
//                text:"infomation"
//                type:FlatGlobal.typeInfo
//            }
//            FlatButton{
//                text:"inverse"
//                type:FlatGlobal.typeInverse
//            }
//            FlatButton{
//                text:"primary"
//                type:FlatGlobal.typePrimary
//            }
//            FlatButton{
//                text:"success"
//                type:FlatGlobal.typeSuccess
//            }
//            FlatButton{
//                text:"warning"
//                type:FlatGlobal.typeWarning
//            }



//        FlatButton{ text:"AddTags"; onClicked: { __createExample(text)} }
//        FlatButton{ text:"CodeEditor"; onClicked: { __createExample(text)} }
//        FlatButton{ text:"RunningAppliction"; onClicked: { __createExample(text)} }
//        FlatButton{ text:"ShowMenuInWindow"; onClicked: { __createExample(text)} }
//        FlatButton{ text:"SampleVideoPlayer"; onClicked: { __createExample(text)} }
//        FlatButton{ text:"BaiduTranslate"; onClicked: { __createExample(text)} }
//        FlatButton{ text:"FBIWarning"; onClicked: { __createExample(text)} }
//        FlatButton{ text:"FloatingWindow"; onClicked: { __createExample(text)} }
//        FlatButton{ text:"WebBrowser"; onClicked:{ __createExample(text)}}
//        FlatButton{ text:"Test"; onClicked:{ __createExample(text)}}
//        FlatButton{ text:"StackViewDemo"; onClicked:{ __createExample(text)}}
//        FlatButton{ text:"WatchImageOnFullSceen"; onClicked:{ __createExample(text)}}
//        FlatButton{ text:"GroupBoxDemo"; onClicked:{ __createExample(text)}}

//        //![error ] Error - RtlWerpReportException failed with status code :-1073741823. Will try to launch the process directly
//        FlatButton{ text:"ComboBoxDemo";type:FlatGlobal.typeDanger; onClicked:{ __createExample(text)}}
//        //![error ] Error - RtlWerpReportException failed with status code :-1073741823. Will try to launch the process directly

//        FlatButton{ text:"HistorySearchDemo"; onClicked:{ __createExample(text)}}
//        FlatButton{ text:"ButtonType"; onClicked:{ __createExample(text)}}
//        FlatButton{ text:"YouTuBe"; onClicked:{ __createExample(text)}}
//        FlatButton{ text:"DoubanClient"; onClicked:{ __createExample(text)}}

//        FlatButton{ text:"SampleErrorExample"; type:FlatGlobal.typeDanger; onClicked:{ __createExample(text)}}
//        FlatButton{ text:"FormWindow"; type:FlatGlobal.typeInverse; onClicked:{ __createExample(text)}}
//        FlatButton{ text:"USBWebClient"; type:FlatGlobal.typeInverse; onClicked:{ __createExample(text)}}

//        //USBWebClient
//        FlatButton{ text:"about"; type: FlatGlobal.typeInfo; onClicked: aboutDialog.show()}
//        FlatButton{ text:"get a image"; type: FlatGlobal.typeWarning; onClicked: FlatGlobal.saveImageToFile(flow,"flow.png")}
//    }

//    ErrorDialog{ id:errorDialog; }

//    FlatDialog{
//        id:aboutDialog
//        width: 400
//        height: 300
//        title:"About FlatUI and QtQuick"
//        content:Item{
//            Column{
//                spacing:10
//                Text{
//                    width: parent.width
//                    anchors.margins: 10
//                    wrapMode: Text.WordWrap
//                    text:"look at http://www.bootcss.com/p/flat-ui/ and http://www.qt.io/"
//                    font:FlatGlobal.font
//                }
//                Row{
//                    spacing:10
//                    FlatButton{
//                        text:"look FlatUI"
//                        onClicked: Qt.openUrlExternally("http://www.bootcss.com/p/flat-ui");
//                    }
//                    FlatButton{
//                        text:"look QtQuick"
//                        onClicked: Qt.openUrlExternally("http://www.qt.io");
//                    }
//                }
//            }
//        }
//    }

//    function __createExample(exampleName){
//        var elementUrl = Qt.resolvedUrl(String("demo/"+exampleName+"/"+exampleName+".qml"));
//        var properties = {
//            x:  window.x + 50,
//            y: window.y + 50
//        }
//        FlatGlobal.createQmlObjectFromUrl2(elementUrl, null,
//                                           properties, function(win){
//            win.show();
//        });

//    }

//}
