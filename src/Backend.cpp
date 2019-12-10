#include "Backend.hpp"

#include <QString>

#include <boost/lexical_cast.hpp>

#include <UnitConvert.hpp>
#include <UnitConvert/GlobalUnitRegistry.hpp>

QString Backend::convert(const QString& q, const QString& u)
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
