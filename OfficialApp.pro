QT += quick core quickcontrols2

TARGET = OfficialApp
CONFIG += c++17

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
    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
    ANDROID_ABIS = armeabi-v7a arm64-v8a x86_64
    
    # Use Qt 6 configurations for modern Android support
    QT += core-private
    
    # Create the android directory if it doesn't exist
    !exists($$PWD/android) {
        QMAKE_POST_LINK += mkdir -p $$PWD/android
    }
    
    # Set Android SDK Build Tools version
    ANDROID_SDK_BUILD_TOOLS_REVISION = 33.0.0
    
    # Set Android SDK API level
    ANDROID.sdk.api_level = 33
    
    # Enable Material style for Android
    QT += quickcontrols2
}

# Set application files for Android
android {
    DISTFILES += \
        android/AndroidManifest.xml \
        android/res/values/libs.xml \
        android/build.gradle
        
    # Configure for Qt 6.5+ deployment
    ANDROID.deployment_dependencies += \
        $$[QT_INSTALL_QML]/QtQuick/Controls/Material \
        $$[QT_INSTALL_QML]/QtQuick/Controls/Universal \
        $$[QT_INSTALL_QML]/QtQuick/Controls/Basic
}