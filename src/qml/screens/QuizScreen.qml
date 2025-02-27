import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../components"

Item {
    id: quizScreen
    anchors.fill: parent
    
    signal back()
    
    // Top bar
    TopBar {
        id: topBar
        title: "Quizzes"
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
                color: "#4F86C6"
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 5
                    
                    Label {
                        Layout.fillWidth: true
                        text: "Quizzes"
                        font.pixelSize: 22
                        font.bold: true
                        color: "white"
                    }
                    
                    Label {
                        Layout.fillWidth: true
                        text: "Test your knowledge about your partner."
                        font.pixelSize: 16
                        wrapMode: Text.WordWrap
                        color: "white"
                    }
                }
            }
            
            // Quiz questions
            Repeater {
                model: appModel.quizQuestions
                
                delegate: Item {
                    Layout.fillWidth: true
                    Layout.preferredHeight: questionColumn.height + 40
                    Layout.margins: 20
                    
                    property var questionData: modelData
                    
                    Rectangle {
                        anchors.fill: parent
                        color: "white"
                        radius: 12
                        border.color: "#EEEEEE"
                        border.width: 1
                        
                        ColumnLayout {
                            id: questionColumn
                            anchors.fill: parent
                            anchors.margins: 20
                            spacing: 15
                            
                            QuestionCard {
                                Layout.fillWidth: true
                                questionText: questionData.question
                                category: questionData.category
                                userAnswer: questionData.userAnswer
                                
                                onAnswered: function(answer) {
                                    appModel.answerQuizQuestion(index, answer);
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