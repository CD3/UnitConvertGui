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
    return app.exec();
}
