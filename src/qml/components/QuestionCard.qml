import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: questionCard
    width: parent.width - 40
    height: contentLayout.height + 40
    radius: 12
    color: "white"
    border.color: "#EEEEEE"
    border.width: 1
    
    property string questionText: ""
    property string category: ""
    property string userAnswer: ""
    property bool showAnswer: true
    
    signal answered(string answer)
    
    ColumnLayout {
        id: contentLayout
        width: parent.width - 40
        anchors.centerIn: parent
        spacing: 15
        
        // Question category
        Label {
            Layout.fillWidth: true
            text: category
            font.pixelSize: 14
            color: window.secondaryColor
            font.bold: true
        }
        
        // Question text
        Label {
            Layout.fillWidth: true
            text: questionText
            font.pixelSize: 18
            wrapMode: Text.WordWrap
            color: window.textColor
        }
        
        // Input for answer
        Rectangle {
            Layout.fillWidth: true
            height: 50
            color: window.lightGrayColor
            radius: 8
            visible: showAnswer && userAnswer === ""
            
            TextInput {
                id: answerInput
                anchors.fill: parent
                anchors.margins: 10
                verticalAlignment: TextInput.AlignVCenter
                font.pixelSize: 16
                clip: true
                
                property string placeholderText: "Type your answer..."
                
                Text {
                    text: answerInput.placeholderText
                    color: "#aaa"
                    visible: !answerInput.text
                    font: answerInput.font
                    anchors.fill: parent
                    verticalAlignment: TextInput.AlignVCenter
                }
            }
        }
        
        // Submit button
        CustomButton {
            Layout.fillWidth: true
            text: "Submit"
            buttonColor: window.secondaryColor
            visible: showAnswer && userAnswer === ""
            
            onClicked: {
                if (answerInput.text.trim() !== "") {
                    questionCard.answered(answerInput.text.trim())
                }
            }
        }
        
        // Display answer if it exists
        Rectangle {
            Layout.fillWidth: true
            height: answerLabel.contentHeight + 20
            color: window.lightGrayColor
            radius: 8
            visible: userAnswer !== ""
            
            Label {
                id: answerLabel
                anchors.fill: parent
                anchors.margins: 10
                text: "Your answer: " + userAnswer
                font.pixelSize: 16
                wrapMode: Text.WordWrap
                color: window.textColor
            }
        }
    }
}