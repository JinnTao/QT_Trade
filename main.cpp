#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <iostream>
using std::cout;
using std::endl;
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.addImportPath("../otcTrade/plugin");
    QStringList mylist = engine.importPathList();
    for (auto i = 0 ; i <  mylist.size();i++) {
        //cout <<"list =>" <<  mylist.at(i).toLocal8Bit().constData() << endl;
    }

    engine.load(QUrl(QStringLiteral("qrc:/view/main.qml")));

    return app.exec();
}
