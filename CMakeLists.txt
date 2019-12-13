cmake_minimum_required(VERSION 3.1)

project("UnitConvertGui")

find_package(Qt5 COMPONENTS Widgets Qml Quick REQUIRED)
find_package(UnitConvert)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

qt5_add_resources( QT_RESOURCES src/Application.qrc )

add_executable(${PROJECT_NAME} ${QT_RESOURCES} 
  src/main.cpp 
  src/Backend.cpp 
  )

set_target_properties(${PROJECT_NAME} PROPERTIES COMPILE_FLAGS "-Wall -Werror -std=c++11 -fstrict-aliasing -pedantic-errors -pedantic -Wno-deprecated-declarations -Wno-unused-variable")
target_link_libraries(${PROJECT_NAME}
    Qt5::Widgets
    Qt5::Qml
    Qt5::Quick
    UnitConvert::UnitConvert
    )


add_executable(preview ${QT_RESOURCES} 
  src/preview.cpp 
  src/QQmlApplicationPreviewEngine.cpp 
  )

set_target_properties(${PROJECT_NAME} PROPERTIES COMPILE_FLAGS "-Wall -Werror -std=c++11 -fstrict-aliasing -pedantic-errors -pedantic -Wno-deprecated-declarations -Wno-unused-variable")
target_link_libraries(preview
    Qt5::Widgets
    Qt5::Qml
    Qt5::Quick
    )

  install(TARGETS ${PROJECT_NAME} RUNTIME )
