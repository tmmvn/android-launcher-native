cmake_minimum_required(VERSION 3.21.1)

option(BUILD_QDS_COMPONENTS "Build design studio components" ON)

project(launcherApp LANGUAGES CXX)

if(NOT ANDROID)
    message(FATAL_ERROR "Launcher only works on Android")
endif()

set(ANDROID_PACKAGE_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/android)
set(CMAKE_AUTOMOC ON)
set(QT_QML_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/qml)
set(QML_IMPORT_PATH ${QT_QML_OUTPUT_DIRECTORY}
    CACHE STRING "Import paths for Qt Creator's code model"
    FORCE
)

find_package(Qt6 REQUIRED COMPONENTS
    Core
    #Gui
    Qml
    Quick
    Widgets
    Svg
    Network
)

qt_standard_project_setup(REQUIRES 6.7)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

qt_add_executable(${CMAKE_PROJECT_NAME}
    MANUAL_FINALIZATION
    ${CMAKE_CURRENT_SOURCE_DIR}/src/main.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/src/app_environment.h
    #${CMAKE_CURRENT_SOURCE_DIR}/src/import_qml_components_plugins.h
    ${CMAKE_CURRENT_SOURCE_DIR}/src/application.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/src/application.h
    ${CMAKE_CURRENT_SOURCE_DIR}/src/applicationinfo.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/src/applicationinfo.h
    ${CMAKE_CURRENT_SOURCE_DIR}/src/iconimageprovider.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/src/iconimageprovider.h
    ${CMAKE_CURRENT_SOURCE_DIR}/src/launcher.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/src/launcher.h
    ${CMAKE_CURRENT_SOURCE_DIR}/src/packagemanager.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/src/packagemanager.h
    ${CMAKE_CURRENT_SOURCE_DIR}/src/screenvalues.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/src/screenvalues.h
    ${CMAKE_CURRENT_SOURCE_DIR}/src/system.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/src/system.h
    ${ANDROID_PACKAGE_SOURCE_DIR}/src/com/iktwo/qutelauncher/Application.kt
    ${ANDROID_PACKAGE_SOURCE_DIR}/src/com/iktwo/qutelauncher/PackageChangedReceiver.kt
    ${ANDROID_PACKAGE_SOURCE_DIR}/src/com/iktwo/qutelauncher/QuteLauncher.kt
    ${ANDROID_PACKAGE_SOURCE_DIR}/AndroidManifest.xml
)

set_property(TARGET ${CMAKE_PROJECT_NAME} APPEND PROPERTY QT_ANDROID_PACKAGE_SOURCE_DIR
   ${ANDROID_PACKAGE_SOURCE_DIR})
#set_target_properties(${CMAKE_PROJECT_NAME} PROPERTIES
#    ANDROID_PROGUARD_CONFIG_OPTIONS "-keep class android.support.multidex.** { *; }"
#    ANDROID_PROGUARD_CONFIG_OPTIONS "-keep class androidx.multidex.** { *; }"
#    ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android"
#    ANDROID_EXTRA_LIBS "androidx.multidex:multidex:2.0.1"
#    )

qt_add_resources(${CMAKE_PROJECT_NAME} "configuration"
    PREFIX "/"
    FILES
        qtquickcontrols2.conf
)

file(GLOB_RECURSE ANDROID_RESOURCES
        "${ANDROID_PACKAGE_SOURCE_DIR}/res/values/*.*"
        "${ANDROID_PACKAGE_SOURCE_DIR}/res/value-sw600dp/*.*"
        "${ANDROID_PACKAGE_SOURCE_DIR}/res/values-v21/*.*"
        "${ANDROID_PACKAGE_SOURCE_DIR}/res/drawable-hdpi/*.*"
        "${ANDROID_PACKAGE_SOURCE_DIR}/res/drawable-mdpi/*.*"
        "${ANDROID_PACKAGE_SOURCE_DIR}/res/drawable-xhdpi/*.*"
        "${ANDROID_PACKAGE_SOURCE_DIR}/res/drawable-xxhdpi/*.*"
        "${ANDROID_PACKAGE_SOURCE_DIR}/res/drawable-xxxhdpi/*.*"
        "${ANDROID_PACKAGE_SOURCE_DIR}/res/mipmap-hdpi/*.*"
        "${ANDROID_PACKAGE_SOURCE_DIR}/res/mipmap-mdpi/*.*"
        "${ANDROID_PACKAGE_SOURCE_DIR}/res/mipmap-xhdpi/*.*"
        "${ANDROID_PACKAGE_SOURCE_DIR}/res/mipmap-xxhdpi/*.*"
        "${ANDROID_PACKAGE_SOURCE_DIR}/res/mipmap-xxxhdpi/*.*"
        "${ANDROID_PACKAGE_SOURCE_DIR}/res/xml/*.*"
    )

#qt_add_resources(RESOURCES "${CMAKE_CURRENT_SOURCE_DIR}/src/resources.qrc")
#    target_sources(${PROJECT_NAME} PRIVATE ${RESOURCES})

target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE
    Qt6::Core
    Qt6::Qml
    Qt6::Quick
    Qt6::Widgets
    Qt6::Svg
    Qt6::Network
    #Qt6::CorePrivate
    #Qt6::Gui
    #Qt6::Widgets
)

if (BUILD_QDS_COMPONENTS)
    message("Building designer components.")

    set(QT_QML_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/qml")

    include(FetchContent)
    FetchContent_Declare(
        ds
        GIT_TAG qds-4.4
        GIT_REPOSITORY https://code.qt.io/qt-labs/qtquickdesigner-components.git
    )

    FetchContent_GetProperties(ds)
    FetchContent_Populate(ds)

    target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE
        QuickStudioComponentsplugin
        QuickStudioEffectsplugin
        QuickStudioApplicationplugin
        FlowViewplugin
        QuickStudioLogicHelperplugin
        QuickStudioMultiTextplugin
        QuickStudioEventSimulatorplugin
        QuickStudioEventSystemplugin
        QuickStudioUtilsplugin
    )

    add_subdirectory(${ds_SOURCE_DIR} ${ds_BINARY_DIR})

    target_compile_definitions(${CMAKE_PROJECT_NAME} PRIVATE
      BULD_QDS_COMPONENTS=true
    )
endif()

#qt_add_library(${CMAKE_PROJECT_NAME} STATIC)
qt_add_qml_module(${CMAKE_PROJECT_NAME}
    URI com.iktwo.qutelauncher
    DESIGNER_SUPPORTED
    QML_FILES
        qml/main.qml
        qml/IntroView.qml
        qml/themes/classic/ApplicationGrid.qml
        qml/themes/classic/ApplicationGridMenu.qml
        qml/themes/classic/ApplicationTile.qml
        qml/themes/classic/ExpandableItem.qml
        qml/themes/classic/ThemeMain.qml
        qml/themes/classic/qmldir
        qml/themes/tiles/ApplicationGrid.qml
        qml/themes/tiles/ApplicationList.qml
        qml/themes/tiles/ApplicationMenu.qml
        qml/themes/tiles/ApplicationSection.qml
        qml/themes/tiles/ColorPicker.qml
        qml/themes/tiles/Configuration.qml
        qml/themes/tiles/SectionNavigator.qml
        qml/themes/tiles/ThemeMain.qml
        qml/themes/tiles/qmldir
        qml/config/Dimensions.qml
        qml/config/Theme.qml
        qml/config/qmldir
        qml/debug/Debug.qml
        qml/debug/qmldir
        qml/components/MenuItem.qml
        qml/components/PressAndHoldMenu.qml
        qml/components/RadioButtonStyleDefault.qml
        qml/components/qmldir
        qml/intro/IntroEnd.qml
        qml/intro/IntroMain.qml
        qml/intro/IntroScreen.qml
        qml/intro/IntroSelection.qml
    RESOURCES
        qml/fonts/fonts.txt
        qml/resources/images/icon.svg
        qml/resources/images/shadow.png
        qml/resources/images/shadow_navigationbar.png
        qml/resources/images/test.png
    SOURCES
        ${CMAKE_CURRENT_SOURCE_DIR}/src/main.cpp
)

#add_subdirectory(content)
#add_subdirectory(imports)

#target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE
#    contentplugin
#    launcherplugin
#)

qt_finalize_executable(launcherApp)

include(GNUInstallDirs)
install(TARGETS ${CMAKE_PROJECT_NAME}
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

qt_generate_deploy_app_script(
 TARGET ${CMAKE_PROJECT_NAME}
 OUTPUT_SCRIPT deploy_script
 NO_UNSUPPORTED_PLATFORM_ERROR
)
install(SCRIPT ${deploy_script})

# make IDEs aware of the QML import path
set(QML_IMPORT_PATH ${PROJECT_BINARY_DIR}/qml CACHE PATH
    "Path to the custom QML components defined by the project")
