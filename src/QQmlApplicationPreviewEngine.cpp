#include "QQmlApplicationPreviewEngine.hpp"

QQmlApplicationPreviewEngine::QQmlApplicationPreviewEngine(QObject *parent)
    : QQmlApplicationEngine(parent)
{

}

void QQmlApplicationPreviewEngine::clearCache()
{
    this->clearComponentCache();
}
