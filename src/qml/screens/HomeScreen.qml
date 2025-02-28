import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../components"

Item {
    id: homeScreen
    anchors.fill: parent
    
    signal navigateToScreen(string screenName)
    
    // Top bar
    TopBar {
        id: topBar
        title: "Official App"
        showBackButton: false
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
            
            // App title and description
            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: 120
                
                Rectangle {
                    anchors.fill: parent
                    color: window.primaryColor
                    
                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 10
                        
                        Label {
                            Layout.fillWidth: true
                            text: "Build a Stronger Relationship"
                            font.pixelSize: 24
                            font.bold: true
                            color: "white"
                        }
                        
                        Label {
                            Layout.fillWidth: true
                            text: "A relationship app designed to make sure you two are as tight as can be."
                            font.pixelSize: 16
                            wrapMode: Text.WordWrap
                            color: "white"
                        }
                    }
                }
            }
            
            // Daily question
            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: 180
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
                        spacing: 10
                        
                        Label {
                            Layout.fillWidth: true
                            text: "Daily Question"
                            font.pixelSize: 18
                            font.bold: true
                            color: window.textColor
                        }
                        
                        Label {
                            Layout.fillWidth: true
                            text: appModel.dailyQuestion
                            font.pixelSize: 16
                            wrapMode: Text.WordWrap
                            color: window.textColor
                        }
                        
                        CustomButton {
                            Layout.fillWidth: true
                            text: "New Question"
                            onClicked: appModel.generateNewDailyQuestion()
                        }
                    }
                }
            }
            
            // Feature buttons
            GridLayout {
                Layout.fillWidth: true
                Layout.margins: 20
                columns: 2
                columnSpacing: 20
                rowSpacing: 20
                
                // Discovery button
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 150
                    radius: 12
                    color: window.secondaryColor
                    
                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 15
                        spacing: 10
                        
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 8
                            
                            Label {
                                text: "🔍"
                                font.pixelSize: 22
                                color: "white"
                            }
                            
                            Label {
                                Layout.fillWidth: true
                                text: "Discovery"
                                font.pixelSize: 18
                                font.bold: true
                                color: "white"
                            }
                        }
                        
                        Label {
                            Layout.fillWidth: true
                            text: "Learn everything there is to know about your favorite person."
                            font.pixelSize: 14
                            wrapMode: Text.WordWrap
                            color: "white"
                        }
                    }
                    
                    MouseArea {
                        anchors.fill: parent
                        onClicked: navigateToScreen("discovery")
                    }
                }
                
                // Quiz button
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 150
                    radius: 12
                    color: "#4F86C6"
                    
                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 15
                        spacing: 10
                        
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 8
                            
                            Label {
                                text: "❓"
                                font.pixelSize: 22
                                color: "white"
                            }
                            
                            Label {
                                Layout.fillWidth: true
                                text: "Quizzes"
                                font.pixelSize: 18
                                font.bold: true
                                color: "white"
                            }
                        }
                        
                        Label {
                            Layout.fillWidth: true
                            text: "Test your knowledge about your partner."
                            font.pixelSize: 14
                            wrapMode: Text.WordWrap
                            color: "white"
                        }
                    }
                    
                    MouseArea {
                        anchors.fill: parent
                        onClicked: navigateToScreen("quiz")
                    }
                }
                
                // Conversation button
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 150
                    radius: 12
                    color: "#E46651"
                    
                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 15
                        spacing: 10
                        
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 8
                            
                            Label {
                                text: "💬"
                                font.pixelSize: 22
                                color: "white"
                            }
                            
                            Label {
                                Layout.fillWidth: true
                                text: "Conversation"
                                font.pixelSize: 18
                                font.bold: true
                                color: "white"
                            }
                        }
                        
                        Label {
                            Layout.fillWidth: true
                            text: "Interesting conversation starters to deepen your connection."
                            font.pixelSize: 14
                            wrapMode: Text.WordWrap
                            color: "white"
                        }
                    }
                    
                    MouseArea {
                        anchors.fill: parent
                        onClicked: navigateToScreen("conversation")
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