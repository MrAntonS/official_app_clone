import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../components"

Item {
    id: discoveryScreen
    anchors.fill: parent
    
    signal back()
    
    // Top bar
    TopBar {
        id: topBar
        title: "Discovery"
        showBackButton: true
        
        onBackClicked: back()
    }
    
    // Main content
    ScrollView {
        anchors.top: topBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 0
        clip: true
        
        ColumnLayout {
            width: parent.width
            spacing: 20
            
            // Header
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 100
                color: window.secondaryColor
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 5
                    
                    Label {
                        Layout.fillWidth: true
                        text: "Discovery"
                        font.pixelSize: 22
                        font.bold: true
                        color: "white"
                    }
                    
                    Label {
                        Layout.fillWidth: true
                        text: "Learn everything there is to know about your favorite person."
                        font.pixelSize: 16
                        wrapMode: Text.WordWrap
                        color: "white"
                    }
                }
            }
            
            // Discovery categories
            Repeater {
                model: appModel.discoveryItems
                
                delegate: Item {
                    Layout.fillWidth: true
                    Layout.preferredHeight: categoryColumn.height + 40
                    Layout.margins: 20
                    
                    Rectangle {
                        anchors.fill: parent
                        color: "white"
                        radius: 12
                        border.color: "#EEEEEE"
                        border.width: 1
                        
                        ColumnLayout {
                            id: categoryColumn
                            anchors.fill: parent
                            anchors.margins: 20
                            spacing: 15
                            
                            // Category title
                            Label {
                                Layout.fillWidth: true
                                text: modelData.category
                                font.pixelSize: 18
                                font.bold: true
                                color: window.textColor
                            }
                            
                            // Discovery prompts
                            Repeater {
                                model: modelData.prompts
                                
                                delegate: ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 5
                                    
                                    // Question text
                                    RowLayout {
                                        Layout.fillWidth: true
                                        spacing: 10
                                        
                                        Rectangle {
                                            width: 20
                                            height: 20
                                            radius: 10
                                            color: promptData.completed ? window.secondaryColor : window.lightGrayColor
                                            
                                            Text {
                                                anchors.centerIn: parent
                                                text: "✓"
                                                color: "white"
                                                visible: promptData.completed
                                                font.pixelSize: 12
                                            }
                                        }
                                        
                                        Label {
                                            Layout.fillWidth: true
                                            text: promptData.text
                                            font.pixelSize: 16
                                            wrapMode: Text.WordWrap
                                            color: window.textColor
                                        }
                                    }
                                    
                                    // Answer input
                                    Rectangle {
                                        Layout.fillWidth: true
                                        height: visible ? 50 : 0
                                        color: window.lightGrayColor
                                        radius: 8
                                        visible: !promptData.completed
                                        
                                        TextInput {
                                            id: promptInput
                                            anchors.fill: parent
                                            anchors.margins: 10
                                            verticalAlignment: TextInput.AlignVCenter
                                            font.pixelSize: 16
                                            clip: true
                                            
                                            property string placeholderText: "Type your answer..."
                                            
                                            Text {
                                                text: promptInput.placeholderText
                                                color: "#aaa"
                                                visible: !promptInput.text
                                                font: promptInput.font
                                                anchors.fill: parent
                                                verticalAlignment: TextInput.AlignVCenter
                                            }
                                        }
                                    }
                                    
                                    // Submit button
                                    CustomButton {
                                        Layout.fillWidth: true
                                        text: "Save"
                                        buttonColor: window.secondaryColor
                                        visible: !promptData.completed
                                        
                                        onClicked: {
                                            if (promptInput.text.trim() !== "") {
                                                // This would normally update the model in a real app
                                                promptData.completed = true
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            // Space at bottom
            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: 40
            }
        }
    }
}