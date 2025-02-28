import QtQuick
import QtQuick.Controls

Button {
    id: customButton
    
    property color buttonColor: window.primaryColor
    property color textColor: "white"
    property int buttonRadius: 8
    
    contentItem: Text {
        text: customButton.text
        font.pixelSize: 16
        font.bold: true
        color: textColor
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    
    background: Rectangle {
        radius: buttonRadius
        color: customButton.pressed ? Qt.darker(buttonColor, 1.2) : 
               customButton.hovered ? Qt.lighter(buttonColor, 1.1) : buttonColor
    }
}