
cmake_minimum_required(VERSION 2.6.0)

#SET(QT_MIN_VERSION "4.5.0")
#FIND_PACKAGE(Qt4 REQUIRED)

file (GLOB SRC_FILES *.cpp)

#set (FILES_TO_TRANSLATE ${SRC_FILES})
#file (GLOB TRANSLATIONS_FILES *.ts)
#
#option(UPDATE_TRANSLATIONS "Update source translation translations/*.ts
#files(WARNING: make clean will delete the source .ts files! Danger!)")
#
#if(UPDATE_TRANSLATIONS)
#  qt4_create_translation(QM_FILES ${FILES_TO_TRANSLATE} ${TRANSLATIONS_FILES})
#else(UPDATE_TRANSLATIONS)
#  qt4_add_translation(QM_FILES ${TRANSLATIONS_FILES})
#endif(UPDATE_TRANSLATIONS)

add_executable(@name@
	${SRC_FILES}
#	${QM_FILES}
)

#target_link_libraries(@name@
#	${QT_QTCORE_LIBRARY}
#	${QT_QTGUI_LIBRARY}
#)
#
#include_directories(${QT_INCLUDE_DIR})

install(TARGETS @name@ RUNTIME DESTINATION bin)

