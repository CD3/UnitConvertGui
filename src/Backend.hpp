#ifndef Backend_hpp
#define Backend_hpp

#include <QFile>
#include <QObject>
#include <set>
#include <deque>
#include <string>

/** @file Backend.hpp
 * @brief
 * @author C.D. Clark III
 * @date 12/09/19
 */
class Backend : public QObject
{
  Q_OBJECT
 protected:
  QFile                 unitsFile;
  std::set<std::string>   userDefinedUnitsSeen;
  std::deque<std::string> userDefinedUnits;

 public:
  Backend();
  ~Backend() = default;
  Q_INVOKABLE QString convert(const QString& q, const QString& u) const;
  Q_INVOKABLE QString addUnit(const QString& eq);
  Q_INVOKABLE void saveUserDefinedUnits();
};

#endif  // include protector
