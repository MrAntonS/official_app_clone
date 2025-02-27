QT += quick core

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