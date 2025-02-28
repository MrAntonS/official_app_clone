#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>
#include <QDebug>
#include <QDir>
#include "appmodel.h"

#ifdef Q_OS_ANDROID
#include <QtAndroid>
#endif

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QCoreApplication::setAttribute(Qt::AA_UseHighDpiPixmaps);
    
    qDebug() << "Application starting...";
    
    QGuiApplication app(argc, argv);
    app.setOrganizationName("OfficialApp");
    app.setOrganizationDomain("example.com");
    app.setApplicationName("OfficialApp");
    
    qDebug() << "Setting application style...";
    
    // Set application style to Material (modern Android look)
    QQuickStyle::setStyle("Material");
    
    QQmlApplicationEngine engine;
    
    qDebug() << "Creating AppModel...";
    AppModel appModel;
    engine.rootContext()->setContextProperty("appModel", &appModel);
    
    qDebug() << "Loading main.qml...";
    
    // List all available resources
    qDebug() << "Available QML resources:";
    QDir resourceDir(":/");
    for (const QString &resource : resourceDir.entryList()) {
        qDebug() << " - " << resource;
    }
    
    // Add a handler for QML warnings
    QObject::connect(&engine, &QQmlApplicationEngine::warnings,
                     [](const QList<QQmlError> &warnings) {
        for (const QQmlError &error : warnings) {
            qWarning() << "QML Warning:" << error.toString();
        }
    });
    
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl) {
            qDebug() << "Failed to create object for" << objUrl;
            QCoreApplication::exit(-1);
        } else {
            qDebug() << "Successfully created object for" << objUrl;
        }
    }, Qt::QueuedConnection);
    
    engine.load(url);
    
    if (engine.rootObjects().isEmpty()) {
        qDebug() << "No root objects created - application failed to load QML";
        return -1;
    }
    
    qDebug() << "Application started successfully";
    return app.exec();
}