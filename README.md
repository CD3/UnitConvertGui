# UnitConvertGui

This is a small Qt application for doing unit conversions. It uses the [`UnitConvert` library](https://github.com/CD3/UnitConvert) for doing
conversions, and `qml` for the GUI. It is really just a project for me to learn how to use
Qt's QML to write applications.

## Building

The easiest way to build `UnitConvertGui` is to use [Conan](https://conan.io/) to install its dependencies.

```bash
git clone https://github.com/CD3/UnitConvertGui.git
cd UnitConvertGui
mkdir build
cd build
conan install .. --build missing
source ./activate.sh
cmake ..
cmake --build .
```
