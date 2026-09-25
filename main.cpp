#include <QObject>

#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QQmlContext>

#include <QDebug>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("client", "Main");

    return app.exec();
}
