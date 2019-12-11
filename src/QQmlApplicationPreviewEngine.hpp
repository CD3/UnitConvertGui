#pragma once

#include <QQmlApplicationEngine>

class QQmlApplicationPreviewEngine : public QQmlApplicationEngine
{
    Q_OBJECT
public:
    explicit QQmlApplicationPreviewEngine(QObject *parent = nullptr);

    Q_INVOKABLE void clearCache();
};
