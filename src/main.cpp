#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "Backend.hpp"


int main(int argc, char** argv)
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication app(argc, argv);
    QQmlApplicationEngine engine(QUrl(QStringLiteral("qrc:///MainWindow.qml")));
    Backend backend;
    engine.rootContext()->setContextProperty("backend", &backend);
    QObject::connect(&app,SIGNAL(aboutToQuit()),&backend,SLOT(saveUserDefinedUnits()));
    return app.exec();
}
