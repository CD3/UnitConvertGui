#include <QApplication>
#include <QQmlContext>
#include <QString>
#include <iostream>

#include "Backend.hpp"
#include "QQmlApplicationPreviewEngine.hpp"

int main(int argc, char** argv)
{
  if (argc < 2) {
    std::cerr<< "Usage: ./preview path/to/qml/file.qml" << std::endl;
    return 1;
  }
  QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
  QApplication                 app(argc, argv);
  QQmlApplicationPreviewEngine engine;

  QString previewApp(argv[1]);
  //QString previewComponent("");

  engine.rootContext()->setContextProperty("QmlEngine", &engine);
  //engine.rootContext()->setContextProperty("QmlPreviewComponent", &previewComponent);
  engine.load(QUrl(previewApp));
  return app.exec();
}
