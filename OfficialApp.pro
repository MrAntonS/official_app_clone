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
    ANDROID_ABIS = armeabi-v7a arm64-v8a x86_64
    
    # Set Android SDK Build Tools version
    ANDROID_SDK_BUILD_TOOLS_REVISION = 33.0.0
    
    # Set Android SDK API level
    ANDROID.sdk.api_level = 33
    
    # For debugging
    QMAKE_CXXFLAGS += -g
    
    # Add log library for Android debugging
    LIBS += -landroid
    
    # Force deployment of necessary plugins
    QT += quickcontrols2
    
    # Configure the binary name
    ANDROID_TARGET_ARCH = $${QT_ARCH}
    equals(ANDROID_TARGET_ARCH, x86_64): ANDROID_EXTRA_LIBS += $$PWD/android/libs/x86_64/
    equals(ANDROID_TARGET_ARCH, arm64-v8a): ANDROID_EXTRA_LIBS += $$PWD/android/libs/arm64-v8a/
    equals(ANDROID_TARGET_ARCH, armeabi-v7a): ANDROID_EXTRA_LIBS += $$PWD/android/libs/armeabi-v7a/
    
    # Explicitly add Qt libraries for Android
    QTPLUGIN += qtvirtualkeyboardplugin
}

# Set application files for Android
android {
    DISTFILES += \
        android/AndroidManifest.xml \
        android/res/values/libs.xml \
        android/build.gradle
    
    # Configure Qt modules for Android deployment
    ANDROID.deployment_dependencies += \
        $$[QT_INSTALL_QML]/QtCore \
        $$[QT_INSTALL_QML]/QtQml \
        $$[QT_INSTALL_QML]/QtQuick \
        $$[QT_INSTALL_QML]/QtQuick/Controls \
        $$[QT_INSTALL_QML]/QtQuick/Controls/Material \
        $$[QT_INSTALL_QML]/QtQuick/Controls/Universal \
        $$[QT_INSTALL_QML]/QtQuick/Controls/Basic \
        $$[QT_INSTALL_QML]/QtQuick/Layouts \
        $$[QT_INSTALL_QML]/QtQuick/Window
        
    # Enable deployment of QML imports
    ANDROID_DEPLOYMENT_DEPENDENCIES = true
    
    # Make sure Qt JAR files are included in the APK
    ANDROID_BUNDLED_JAR_DEPENDENCIES += \
        jar/QtAndroid.jar
    
    # Deploy Qt libraries required for your application
    ANDROID_EXTRA_PLUGINS += \
        $$[QT_INSTALL_PLUGINS]/platforms \
        $$[QT_INSTALL_PLUGINS]/iconengines \
        $$[QT_INSTALL_PLUGINS]/imageformats \
        $$[QT_INSTALL_QML]/QtQml \
        $$[QT_INSTALL_QML]/QtQuick \
        $$[QT_INSTALL_QML]/QtQuick/Controls \
        $$[QT_INSTALL_QML]/QtQuick/Controls/Material
        
    OTHER_FILES += android/src/org/qtproject/qt6/android/bindings/QtActivity.java
}