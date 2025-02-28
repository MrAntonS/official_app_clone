import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: topBar
    width: parent.width
    height: 60
    color: window.primaryColor
    
    property string title: ""
    property bool showBackButton: true
    
    signal backClicked()
    
    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        spacing: 10
        
        // Back button
        Item {
            Layout.preferredWidth: showBackButton ? 40 : 0
            Layout.fillHeight: true
            visible: showBackButton
            
            Rectangle {
                id: backButton
                width: 40
                height: 40
                radius: 20
                color: "transparent"
                anchors.verticalCenter: parent.verticalCenter
                
                Text {
                    text: "←"
                    font.pixelSize: 24
                    color: "white"
                    anchors.centerIn: parent
                }
                
                MouseArea {
                    anchors.fill: parent
                    onClicked: backClicked()
                }
            }
        }
        
        // Title with logo
        RowLayout {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter
            spacing: 8
            
            Label {
                text: "❤️"
                font.pixelSize: 22
                color: "white"
                visible: !showBackButton // Only show on main screen
            }
            
            Label {
                Layout.fillWidth: true
                text: title
                font.pixelSize: 20
                font.bold: true
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
        
        // Spacer to balance the back button
        Item {
            Layout.preferredWidth: showBackButton ? 40 : 0
            Layout.fillHeight: true
            visible: showBackButton
        }
    }
}