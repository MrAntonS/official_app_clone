QT += quick core quickcontrols2

TARGET = OfficialApp
CONFIG += c++17

DEFINES += QT_DEPRECATED_WARNINGS

SOURCES += \
    src/cpp/main.cpp \
    src/cpp/appmodel.cpp

HEADERS += \
    src/cpp/appmodel.h

RESOURCES += src/qml/qml.qrc \
    src/assets/assets.qrc

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

# Android specific settings
android {
    message("Configuring for Android...")
    QT += core-private gui-private svg
    
    # Create the android directory if it doesn't exist
    !exists($$PWD/android) {
        QMAKE_POST_LINK += mkdir -p $$PWD/android
    }
    
    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
    
    # Limit to x86_64 only for testing
    ANDROID_ABIS = x86_64
    
    # Set Android SDK Build Tools version
    ANDROID_SDK_BUILD_TOOLS_REVISION = 33.0.0
    
    # Set Android SDK API level
    ANDROID.sdk.api_level = 33
    
    # Important: Make sure to copy Qt files into proper location
    ANDROID_EXTRA_LIBS =  # Clear this to avoid the source not found error
    
    # Enable debugging
    QMAKE_CXXFLAGS += -g
    
    # Add required libraries
    LIBS += -landroid
    QT += quickcontrols2
    
    # For Material components
    QT += quickcontrols2-private
}

# Set application files for Android
android {
    DISTFILES += \
        android/AndroidManifest.xml \
        android/res/values/libs.xml \
        android/build.gradle
    
    # Make sure these are included in the APK
    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
    
    # Enable bundled build (important!)
    ANDROID_ABIS_DEPLOYMENT_SETTINGS = bundle
    
    # Set the style explicitly
    QT += quickcontrols2
    
    # Deploy Qt libraries required for your application
    QML_IMPORT_PATH = $$[QT_INSTALL_QML]
    
    # Deploy libraries bundled with your APK
    ANDROID_EXTRA_LIBS =
    
    # Make sure all needed QML modules are bundled
    QML_IMPORT_DEPENDENCIES += \
        QtQuick \
        QtQuick.Controls \
        QtQuick.Controls.Material \
        QtQuick.Layouts
}