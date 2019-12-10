#ifndef Backend_hpp
#define Backend_hpp

#include <QObject>


/** @file Backend.hpp
  * @brief 
  * @author C.D. Clark III
  * @date 12/09/19
  */
class Backend : public QObject
{
  Q_OBJECT
  protected:

  public:
    Backend() = default;
    ~Backend() = default;
    Q_INVOKABLE QString convert(const QString& q, const QString& u);
};


#endif // include protector
