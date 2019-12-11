#include "Backend.hpp"

#include <QDir>
#include <QFile>
#include <QStandardPaths>
#include <QString>
#include <QTextStream>

#include <boost/lexical_cast.hpp>

#include <UnitConvert.hpp>
#include <UnitConvert/GlobalUnitRegistry.hpp>

Backend::Backend() : QObject()
{
  QDir dataDir = QDir(
      QStandardPaths::writableLocation(QStandardPaths::AppLocalDataLocation));
  dataDir.mkpath(".");
  unitsFile.setFileName(dataDir.filePath("unit.txt"));

  UnitRegistry& ureg = getGlobalUnitRegistry();
  ureg.existing_unit_policy = UnitRegistry::EXISTING_UNIT_POLICY::Ignore;
  if (unitsFile.exists()) {
    try {
    ureg.loadUnits(unitsFile.fileName().toStdString());
    if (unitsFile.open(QFile::ReadOnly | QFile::Text)) {
      QTextStream in(&unitsFile);
      while(!in.atEnd())
      {
        userDefinedUnits.push_back(in.readLine().toStdString());
      }
      
      unitsFile.close();
    }
    for( auto &line: userDefinedUnits )
    {
      userDefinedUnitsSeen.insert(line);
    }

    }
    catch(...)
    {}
  } else {
    userDefinedUnits.push_back(
        "# This file contains unit definitions added by the user.");
    userDefinedUnits.push_back(
        "# It was automatically generated, and should NOT be modified.");
  }

  saveUserDefinedUnits();
}

QString Backend::convert(const QString& q, const QString& u) const
{
  UnitRegistry& ureg = getGlobalUnitRegistry();

  try {
    double v =
        ureg.makeQuantity<double>(q.toStdString()).to(u.toStdString()).value();
    QString rq =
        QString(boost::lexical_cast<std::string>(v).c_str()) + QString(" ") + u;
    return rq;
  } catch (const std::runtime_error& e) {
    return e.what();
  } catch (...) {
    return "Unknown Error (Sorry)";
  }
}

QString Backend::addUnit(const QString& eq)
{
  UnitRegistry& ureg = getGlobalUnitRegistry();

  try {
    std::string unit_def = eq.toStdString();
    if(userDefinedUnitsSeen.count(unit_def) == 0)
    {
      userDefinedUnits.push_back(unit_def);
      ureg.addUnit(unit_def);
    }
    return "";
  } catch (const std::runtime_error& e) {
    return e.what();
  } catch (...) {
    return "Unknown Error (Sorry)";
  }
}

void Backend::saveUserDefinedUnits()
{
  if (unitsFile.open(QFile::WriteOnly | QFile::Text)) {
    QTextStream out(&unitsFile);
    for( auto &line: userDefinedUnits )
    {
      out << line.c_str() << "\n";
    }
    out.flush();
    unitsFile.close();
  }
}
