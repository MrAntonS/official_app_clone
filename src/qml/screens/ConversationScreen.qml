import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../components"

Item {
    id: conversationScreen
    anchors.fill: parent
    
    signal back()
    
    // Top bar
    TopBar {
        id: topBar
        title: "Conversation Starters"
        showBackButton: true
        
        onBackClicked: back()
    }
    
    // Main content
    ColumnLayout {
        anchors.top: topBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 0
        spacing: 20
        
        // Header
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 100
            color: "#E46651"
            
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 5
                
                Label {
                    Layout.fillWidth: true
                    text: "Conversation Starters"
                    font.pixelSize: 22
                    font.bold: true
                    color: "white"
                }
                
                Label {
                    Layout.fillWidth: true
                    text: "Interesting conversation starters to deepen your connection."
                    font.pixelSize: 16
                    wrapMode: Text.WordWrap
                    color: "white"
                }
            }
        }
        
        // Current conversation starter
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.margins: 20
            
            Rectangle {
                anchors.fill: parent
                color: "white"
                radius: 12
                border.color: "#EEEEEE"
                border.width: 1
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 20
                    
                    // Card icon
                    Rectangle {
                        Layout.alignment: Qt.AlignHCenter
                        width: 80
                        height: 80
                        radius: 40
                        color: "#E46651"
                        
                        Text {
                            anchors.centerIn: parent
                            text: "❓"
                            font.pixelSize: 40
                            color: "white"
                        }
                    }
                    
                    // Question text
                    Label {
                        Layout.fillWidth: true
                        Layout.preferredHeight: contentHeight
                        text: appModel.conversationStarters.length > 0 ? 
                              appModel.conversationStarters[0].text : "No conversation starters available"
                        font.pixelSize: 24
                        font.bold: true
                        wrapMode: Text.WordWrap
                        horizontalAlignment: Text.AlignHCenter
                        color: window.textColor
                    }
                    
                    // Spacer
                    Item {
                        Layout.fillHeight: true
                    }
                    
                    // Next button
                    CustomButton {
                        Layout.fillWidth: true
                        text: "Next Question"
                        buttonColor: "#E46651"
                        
                        onClicked: appModel.getNewConversationStarter()
                    }
                }
            }
        }
    }
}