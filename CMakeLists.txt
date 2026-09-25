cmake_minimum_required(VERSION 3.16)

project(client VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS
    Core 
    Gui 
    Qml 
    Quick
)

qt_standard_project_setup(REQUIRES 6.8)


if(WIN32)
    set(APP_ICON_RESOURCE "${CMAKE_SOURCE_DIR}/resources/app.rc")
endif()

if(APPLE)
    set(MACOSX_BUNDLE_ICON_FILE tomato.icns)
    set(APP_ICON_MACOS "${CMAKE_SOURCE_DIR}/resources/tomato.icns")
    set_source_files_properties(${APP_ICON_MACOS} PROPERTIES MACOSX_PACKAGE_LOCATION "Resources")
endif()

qt_add_executable(pomodoro-cathxrsys
    main.cpp
    ${APP_ICON_RESOURCE}
    ${APP_ICON_MACOS}
)



qt_add_qml_module(pomodoro-cathxrsys
    URI client
    VERSION 1.0
    QML_FILES
        Main.qml
        ThemeDark.qml
        PanelButton.qml
        CircleWave.qml
    RESOURCES
        resources/close.svg
        resources/minimize.svg
        resources/maximize.svg
        resources/icon.svg
        resources/fonts/geologica.ttf
        resources/fonts/SpaceMono-Bold.ttf
        resources/tomato.svg
        resources/play.svg
        resources/pause.svg
        resources/donate.svg
        resources/github.svg
        resources/sounds/tick.wav
        resources/sounds/alarm.wav
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(pomodoro-cathxrsys PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.pomodoro-cathxrsys
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
    ICON "resources/arc_accent.png"  # Путь к иконке (PNG или ICO)
)



target_link_libraries(pomodoro-cathxrsys PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
)



include(GNUInstallDirs)
install(TARGETS pomodoro-cathxrsys
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
