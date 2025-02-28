import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import QtQuick.Controls.Material

ApplicationWindow {
    id: window
    visible: true
    width: 360
    height: 640
    title: "Official App Clone"
    
    // Set Material theme
    Material.theme: Material.Light
    Material.accent: "#FF5A5F"
    Material.primary: "#FF5A5F"

    // Define colors used throughout the app
    property color primaryColor: "#FF5A5F"
    property color secondaryColor: "#00A699"
    property color backgroundColor: "#FFFFFF"
    property color textColor: "#484848"
    property color lightGrayColor: "#F7F7F7"
    
    // Set font sizes that scale appropriately
    property int fontSizeMedium: Qt.application.font.pixelSize * 1.2
    property int fontSizeLarge: Qt.application.font.pixelSize * 1.5
    property int fontSizeXLarge: Qt.application.font.pixelSize * 2.0

    // Main stack view for navigation
    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: homeScreen
    }

    // Home screen component
    Component {
        id: homeScreen
        HomeScreen {
            onNavigateToScreen: function(screenName) {
                switch(screenName) {
                    case "discovery":
                        stackView.push(discoveryScreen);
                        break;
                    case "quiz":
                        stackView.push(quizScreen);
                        break;
                    case "conversation":
                        stackView.push(conversationScreen);
                        break;
                }
            }
        }
    }

    // Discovery screen component
    Component {
        id: discoveryScreen
        DiscoveryScreen {
            onBack: stackView.pop()
        }
    }

    // Quiz screen component
    Component {
        id: quizScreen
        QuizScreen {
            onBack: stackView.pop()
        }
    }

    // Conversation screen component
    Component {
        id: conversationScreen
        ConversationScreen {
            onBack: stackView.pop()
        }
    }
}