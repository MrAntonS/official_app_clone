#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>
#include "appmodel.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QCoreApplication::setAttribute(Qt::AA_UseHighDpiPixmaps);
    
    QGuiApplication app(argc, argv);
    app.setOrganizationName("OfficialApp");
    app.setOrganizationDomain("example.com");
    app.setApplicationName("OfficialApp");
    
    // Set application style to Material (modern Android look)
    QQuickStyle::setStyle("Material");
    
    QQmlApplicationEngine engine;
    
    AppModel appModel;
    engine.rootContext()->setContextProperty("appModel", &appModel);
    
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    
    engine.load(url);
    
    return app.exec();
}