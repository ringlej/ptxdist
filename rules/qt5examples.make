# WARNING: this file is generated with qt5_mk_examples.sh
# do not edit

# broken on PPC
ifdef PTXCONF_ARCH_PPC
PTXCONF_QT5_MODULE_QTCONNECTIVITY :=
PTXCONF_QT5_MODULE_QTQUICK1 :=
PTXCONF_QT5_MODULE_QTSCRIPT :=
PTXCONF_QT5_MODULE_QTWEBENGINE :=
PTXCONF_QT5_MODULE_QTWEBVIEW :=
endif
# QtWebEngine needs at least ARMv6
ifdef PTXCONF_ARCH_ARM
ifndef PTXCONF_ARCH_ARM_V6
PTXCONF_QT5_MODULE_QTWEBENGINE :=
PTXCONF_QT5_MODULE_QTWEBVIEW :=
endif
endif

ifdef PTXCONF_QT5_EXAMPLES
$(STATEDIR)/qt5.targetinstall.post: $(STATEDIR)/qt5.targetinstall2
endif

$(STATEDIR)/qt5.targetinstall2: $(STATEDIR)/qt5.targetinstall
	@$(call targetinfo)
	@$(call install_init, qt5-examples)
	@$(call install_fixup, qt5-examples,PRIORITY,optional)
	@$(call install_fixup, qt5-examples,SECTION,base)
	@$(call install_fixup, qt5-examples,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, qt5-examples,DESCRIPTION,missing)

ifneq ($(strip $(PTXCONF_QT5_MODULE_QTTOOLS)),)
ifdef PTXCONF_QT5_EXAMPLES_ASSISTANT_SIMPLETEXTVIEWER
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/assistant/simpletextviewer/documentation/about.txt)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/assistant/simpletextviewer/documentation/browse.html)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/assistant/simpletextviewer/documentation/filedialog.html)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/assistant/simpletextviewer/documentation/findfile.html)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/assistant/simpletextviewer/documentation/images/browse.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/assistant/simpletextviewer/documentation/images/fadedfilemenu.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/assistant/simpletextviewer/documentation/images/filedialog.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/assistant/simpletextviewer/documentation/images/handbook.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/assistant/simpletextviewer/documentation/images/icon.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/assistant/simpletextviewer/documentation/images/mainwindow.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/assistant/simpletextviewer/documentation/images/open.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/assistant/simpletextviewer/documentation/images/wildcard.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/assistant/simpletextviewer/documentation/index.html)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/assistant/simpletextviewer/documentation/intro.html)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/assistant/simpletextviewer/documentation/openfile.html)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/assistant/simpletextviewer/documentation/simpletextviewer.qch)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/assistant/simpletextviewer/documentation/simpletextviewer.qhc)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/assistant/simpletextviewer/documentation/simpletextviewer.qhcp)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/assistant/simpletextviewer/documentation/simpletextviewer.qhp)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/assistant/simpletextviewer/documentation/wildcardmatching.html)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/assistant/simpletextviewer/simpletextviewer)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTCONNECTIVITY)),)
ifdef PTXCONF_QT5_EXAMPLES_BLUETOOTH_BTCHAT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/bluetooth/btchat/btchat)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTCONNECTIVITY)),)
ifdef PTXCONF_QT5_EXAMPLES_BLUETOOTH_BTFILETRANSFER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/bluetooth/btfiletransfer/btfiletransfer)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTCONNECTIVITY)),)
ifdef PTXCONF_QT5_EXAMPLES_BLUETOOTH_BTSCANNER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/bluetooth/btscanner/btscanner)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTCONNECTIVITY)),)
ifdef PTXCONF_QT5_EXAMPLES_BLUETOOTH_QML_CHAT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/bluetooth/chat/qml_chat)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTCONNECTIVITY)),)
ifdef PTXCONF_QT5_EXAMPLES_BLUETOOTH_HEARTLISTENER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/bluetooth/heartlistener/heartlistener)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTCONNECTIVITY)),)
ifdef PTXCONF_QT5_EXAMPLES_BLUETOOTH_LOWENERGYSCANNER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/bluetooth/lowenergyscanner/lowenergyscanner)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTCONNECTIVITY)),)
ifdef PTXCONF_QT5_EXAMPLES_BLUETOOTH_QML_PICTURETRANSFER
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/bluetooth/picturetransfer/icon.png)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/bluetooth/picturetransfer/qml_picturetransfer)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTCONNECTIVITY)),)
ifdef PTXCONF_QT5_EXAMPLES_BLUETOOTH_PINGPONG
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/bluetooth/pingpong/pingpong)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTCONNECTIVITY)),)
ifdef PTXCONF_QT5_EXAMPLES_BLUETOOTH_QML_SCANNER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/bluetooth/scanner/qml_scanner)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTCANVAS3D)),)
ifdef PTXCONF_QT5_EXAMPLES_CANVAS3D_FRAMEBUFFER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/canvas3d/framebuffer/framebuffer)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTCANVAS3D)),)
ifdef PTXCONF_QT5_EXAMPLES_CANVAS3D_INTERACTION
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/canvas3d/interaction/3dmodels.txt)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/canvas3d/interaction/interaction)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/canvas3d/interaction/readme.txt)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTCANVAS3D)),)
ifdef PTXCONF_QT5_EXAMPLES_CANVAS3D_JSONMODELS
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/canvas3d/jsonmodels/3dmodels.txt)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/canvas3d/jsonmodels/jsonmodels)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/canvas3d/jsonmodels/readme.txt)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTCANVAS3D)),)
ifdef PTXCONF_QT5_EXAMPLES_CANVAS3D_QUICKITEMTEXTURE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/canvas3d/quickitemtexture/quickitemtexture)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTCANVAS3D)),)
ifdef PTXCONF_QT5_EXAMPLES_CANVAS3D_TEXTUREANDLIGHT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/canvas3d/textureandlight/textureandlight)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTCANVAS3D)),)
ifdef PTXCONF_QT5_EXAMPLES_CANVAS3D_THREEJS_CELLPHONE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/canvas3d/threejs/cellphone/cellphone)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTCANVAS3D)),)
ifdef PTXCONF_QT5_EXAMPLES_CANVAS3D_THREEJS_ONEQT
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/canvas3d/threejs/oneqt/ios/Info.plist)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/canvas3d/threejs/oneqt/ios/OneQtIcon29x29.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/canvas3d/threejs/oneqt/ios/OneQtIcon29x29@2x.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/canvas3d/threejs/oneqt/ios/OneQtIcon29x29@2x~ipad.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/canvas3d/threejs/oneqt/ios/OneQtIcon29x29~ipad.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/canvas3d/threejs/oneqt/ios/OneQtIcon40x40@2x.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/canvas3d/threejs/oneqt/ios/OneQtIcon40x40@2x~ipad.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/canvas3d/threejs/oneqt/ios/OneQtIcon40x40~ipad.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/canvas3d/threejs/oneqt/ios/OneQtIcon50x50@2x~ipad.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/canvas3d/threejs/oneqt/ios/OneQtIcon50x50~ipad.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/canvas3d/threejs/oneqt/ios/OneQtIcon57x57.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/canvas3d/threejs/oneqt/ios/OneQtIcon57x57@2x.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/canvas3d/threejs/oneqt/ios/OneQtIcon60x60@2x.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/canvas3d/threejs/oneqt/ios/OneQtIcon72x72@2x~ipad.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/canvas3d/threejs/oneqt/ios/OneQtIcon72x72~ipad.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/canvas3d/threejs/oneqt/ios/OneQtIcon76x76@2x~ipad.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/canvas3d/threejs/oneqt/ios/OneQtIcon76x76~ipad.png)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/canvas3d/threejs/oneqt/oneqt)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTCANVAS3D)),)
ifdef PTXCONF_QT5_EXAMPLES_CANVAS3D_THREEJS_PLANETS
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/canvas3d/threejs/planets/images/plutobump1k.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/canvas3d/threejs/planets/images/plutomap1k.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/canvas3d/threejs/planets/ios/AppIcon29x29.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/canvas3d/threejs/planets/ios/AppIcon29x29@2x.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/canvas3d/threejs/planets/ios/AppIcon29x29@2x~ipad.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/canvas3d/threejs/planets/ios/AppIcon29x29~ipad.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/canvas3d/threejs/planets/ios/AppIcon40x40@2x.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/canvas3d/threejs/planets/ios/AppIcon40x40@2x~ipad.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/canvas3d/threejs/planets/ios/AppIcon40x40~ipad.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/canvas3d/threejs/planets/ios/AppIcon50x50@2x~ipad.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/canvas3d/threejs/planets/ios/AppIcon50x50~ipad.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/canvas3d/threejs/planets/ios/AppIcon57x57.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/canvas3d/threejs/planets/ios/AppIcon57x57@2x.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/canvas3d/threejs/planets/ios/AppIcon60x60@2x.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/canvas3d/threejs/planets/ios/AppIcon72x72@2x~ipad.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/canvas3d/threejs/planets/ios/AppIcon72x72~ipad.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/canvas3d/threejs/planets/ios/AppIcon76x76@2x~ipad.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/canvas3d/threejs/planets/ios/AppIcon76x76~ipad.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/canvas3d/threejs/planets/ios/Info.plist)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/canvas3d/threejs/planets/planets)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_CORELIB_IPC_LOCALFORTUNECLIENT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/corelib/ipc/localfortuneclient/localfortuneclient)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_CORELIB_IPC_LOCALFORTUNESERVER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/corelib/ipc/localfortuneserver/localfortuneserver)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_CORELIB_IPC_SHAREDMEMORY
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/corelib/ipc/sharedmemory/image.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/corelib/ipc/sharedmemory/qt.png)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/corelib/ipc/sharedmemory/sharedmemory)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_CORELIB_JSON_SAVEGAME
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/corelib/json/savegame/savegame)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_CORELIB_THREADS_MANDELBROT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/corelib/threads/mandelbrot/mandelbrot)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_CORELIB_THREADS_QUEUEDCUSTOMTYPE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/corelib/threads/queuedcustomtype/queuedcustomtype)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_CORELIB_THREADS_SEMAPHORES
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/corelib/threads/semaphores/semaphores)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_CORELIB_THREADS_WAITCONDITIONS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/corelib/threads/waitconditions/waitconditions)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_CORELIB_TOOLS_CONTIGUOUSCACHE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/corelib/tools/contiguouscache/contiguouscache)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_CORELIB_TOOLS_CUSTOMTYPE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/corelib/tools/customtype/customtype)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_CORELIB_TOOLS_CUSTOMTYPESENDING
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/corelib/tools/customtypesending/customtypesending)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_DBUS_CHAT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/dbus/chat/chat)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/dbus/chat/org.example.chat.xml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_DBUS_COMPLEXPING
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/dbus/complexpingpong/complexping)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/dbus/complexpingpong/complexpong)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_DBUS_COMPLEXPONG
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/dbus/complexpingpong/complexping)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/dbus/complexpingpong/complexpong)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_DBUS_LISTNAMES
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/dbus/listnames/listnames)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_DBUS_PING
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/dbus/pingpong/ping)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/dbus/pingpong/pong)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_DBUS_PONG
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/dbus/pingpong/ping)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/dbus/pingpong/pong)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_DBUS_REMOTECONTROLLEDCAR_CAR
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/dbus/remotecontrolledcar/car/car)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/dbus/remotecontrolledcar/car/car.xml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_DBUS_REMOTECONTROLLEDCAR_CONTROLLER
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/dbus/remotecontrolledcar/controller/car.xml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/dbus/remotecontrolledcar/controller/controller)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTTOOLS)),)
ifdef PTXCONF_QT5_EXAMPLES_DESIGNER_CALCULATORBUILDER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/designer/calculatorbuilder/calculatorbuilder)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTTOOLS)),)
ifdef PTXCONF_QT5_EXAMPLES_DESIGNER_CALCULATORFORM
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/designer/calculatorform/calculatorform)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTTOOLS)),)
ifdef PTXCONF_QT5_EXAMPLES_DESIGNER_WORLDTIMECLOCKBUILDER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/designer/worldtimeclockbuilder/worldtimeclockbuilder)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTENGINIO)),)
ifdef PTXCONF_QT5_EXAMPLES_ENGINIO_QUICK_IMAGE_GALLERY
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/enginio/quick/image-gallery/image-gallery)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTENGINIO)),)
ifdef PTXCONF_QT5_EXAMPLES_ENGINIO_QUICK_SOCIALTODOS
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/enginio/quick/socialtodos/backendconfig/sharedtodo.zip)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/enginio/quick/socialtodos/socialtodos)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTENGINIO)),)
ifdef PTXCONF_QT5_EXAMPLES_ENGINIO_QUICK_TODOS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/enginio/quick/todos/todos)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTENGINIO)),)
ifdef PTXCONF_QT5_EXAMPLES_ENGINIO_QUICK_USERS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/enginio/quick/users/users)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTENGINIO)),)
ifdef PTXCONF_QT5_EXAMPLES_ENGINIO_WIDGETS_CLOUDADDRESSBOOK
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/enginio/widgets/cloudaddressbook/cloudaddressbook)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTENGINIO)),)
ifdef PTXCONF_QT5_EXAMPLES_ENGINIO_WIDGETS_IMAGE_GALLERY
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/enginio/widgets/image-gallery-cpp/image-gallery)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTENGINIO)),)
ifdef PTXCONF_QT5_EXAMPLES_ENGINIO_WIDGETS_TODOS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/enginio/widgets/todos-cpp/todos)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_GUI_ANALOGCLOCK
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/gui/analogclock/analogclock)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_GUI_OPENGLWINDOW
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/gui/openglwindow/openglwindow)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_GUI_RASTERWINDOW
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/gui/rasterwindow/rasterwindow)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTTOOLS)),)
ifdef PTXCONF_QT5_EXAMPLES_HELP_CONTEXTSENSITIVEHELP
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/help/contextsensitivehelp/contextsensitivehelp)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/help/contextsensitivehelp/docs/amount.html)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/help/contextsensitivehelp/docs/filter.html)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/help/contextsensitivehelp/docs/plants.html)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/help/contextsensitivehelp/docs/rain.html)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/help/contextsensitivehelp/docs/source.html)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/help/contextsensitivehelp/docs/temperature.html)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/help/contextsensitivehelp/docs/time.html)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/help/contextsensitivehelp/docs/wateringmachine.qch)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/help/contextsensitivehelp/docs/wateringmachine.qhc)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/help/contextsensitivehelp/docs/wateringmachine.qhcp)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/help/contextsensitivehelp/docs/wateringmachine.qhp)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTTOOLS)),)
ifdef PTXCONF_QT5_EXAMPLES_LINGUIST_ARROWPAD
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/linguist/arrowpad/arrowpad)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTTOOLS)),)
ifdef PTXCONF_QT5_EXAMPLES_LINGUIST_HELLOTR
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/linguist/hellotr/hellotr)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTTOOLS)),)
ifdef PTXCONF_QT5_EXAMPLES_LINGUIST_TROLLPRINT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/linguist/trollprint/trollprint)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTLOCATION)),)
ifdef PTXCONF_QT5_EXAMPLES_LOCATION_QML_LOCATION_MAPVIEWER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/location/mapviewer/qml_location_mapviewer)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTLOCATION)),)
ifdef PTXCONF_QT5_EXAMPLES_LOCATION_MINIMAL_MAP
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/location/minimal_map/minimal_map)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTLOCATION)),)
ifdef PTXCONF_QT5_EXAMPLES_LOCATION_QML_LOCATION_PLACES
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/location/places/qml_location_places)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTLOCATION)),)
ifdef PTXCONF_QT5_EXAMPLES_LOCATION_PLACES_LIST
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/location/places_list/places_list)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTLOCATION)),)
ifdef PTXCONF_QT5_EXAMPLES_LOCATION_PLACES_MAP
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/location/places_map/places_map)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTLOCATION)),)
ifdef PTXCONF_QT5_EXAMPLES_LOCATION_PLANESPOTTER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/location/planespotter/planespotter)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTMULTIMEDIA)),)
ifdef PTXCONF_QT5_EXAMPLES_MULTIMEDIA_AUDIODECODER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/multimedia/audiodecoder/audiodecoder)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTMULTIMEDIA)),)
ifdef PTXCONF_QT5_EXAMPLES_MULTIMEDIA_AUDIODEVICES
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/multimedia/audiodevices/audiodevices)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTMULTIMEDIA)),)
ifdef PTXCONF_QT5_EXAMPLES_MULTIMEDIA_AUDIOINPUT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/multimedia/audioinput/audioinput)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTMULTIMEDIA)),)
ifdef PTXCONF_QT5_EXAMPLES_MULTIMEDIA_AUDIOOUTPUT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/multimedia/audiooutput/audiooutput)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTMULTIMEDIA)),)
ifdef PTXCONF_QT5_EXAMPLES_MULTIMEDIA_AUDIORECORDER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/multimedia/audiorecorder/audiorecorder)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTMULTIMEDIA)),)
ifdef PTXCONF_QT5_EXAMPLES_MULTIMEDIA_DECLARATIVE_CAMERA
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/declarative-camera/Info.plist)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/multimedia/declarative-camera/declarative-camera)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTMULTIMEDIA)),)
ifdef PTXCONF_QT5_EXAMPLES_MULTIMEDIA_DECLARATIVE_RADIO
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/multimedia/declarative-radio/declarative-radio)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTMULTIMEDIA)),)
ifdef PTXCONF_QT5_EXAMPLES_MULTIMEDIA_RADIO
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/multimedia/radio/radio)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTMULTIMEDIA)),)
ifdef PTXCONF_QT5_EXAMPLES_MULTIMEDIA_VIDEO_QMLVIDEO
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qmlvideo)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qmlvideo.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qmlvideo.svg)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTMULTIMEDIA)),)
ifdef PTXCONF_QT5_EXAMPLES_MULTIMEDIA_VIDEO_QMLVIDEOFILTER_OPENCL
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofilter_opencl/README)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTMULTIMEDIA)),)
ifdef PTXCONF_QT5_EXAMPLES_MULTIMEDIA_VIDEO_QMLVIDEOFX
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/Info.plist)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/android/AndroidManifest.xml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/qmlvideofx)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/qmlvideofx.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/qmlvideofx.svg)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTMULTIMEDIA)),)
ifdef PTXCONF_QT5_EXAMPLES_MULTIMEDIAWIDGETS_CAMERA
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/multimediawidgets/camera/camera)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTMULTIMEDIA)),)
ifdef PTXCONF_QT5_EXAMPLES_MULTIMEDIAWIDGETS_PLAYER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/multimediawidgets/player/player)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTMULTIMEDIA)),)
ifdef PTXCONF_QT5_EXAMPLES_MULTIMEDIAWIDGETS_VIDEOGRAPHICSITEM
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/multimediawidgets/videographicsitem/videographicsitem)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTMULTIMEDIA)),)
ifdef PTXCONF_QT5_EXAMPLES_MULTIMEDIAWIDGETS_VIDEOWIDGET
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/multimediawidgets/videowidget/videowidget)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTMULTIMEDIA)),)
ifdef PTXCONF_QT5_EXAMPLES_MULTIMEDIAWIDGETS_CUSTOMVIDEOSURFACE_CUSTOMVIDEOITEM
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/multimediawidgets/customvideosurface/customvideoitem/customvideoitem)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTMULTIMEDIA)),)
ifdef PTXCONF_QT5_EXAMPLES_MULTIMEDIAWIDGETS_CUSTOMVIDEOSURFACE_CUSTOMVIDEOWIDGET
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/multimediawidgets/customvideosurface/customvideowidget/customvideowidget)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_NETWORK_BEARERMONITOR
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/network/bearermonitor/bearermonitor)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_NETWORK_BLOCKINGFORTUNECLIENT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/network/blockingfortuneclient/blockingfortuneclient)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_NETWORK_BROADCASTRECEIVER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/network/broadcastreceiver/broadcastreceiver)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_NETWORK_BROADCASTSENDER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/network/broadcastsender/broadcastsender)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_NETWORK_DNSLOOKUP
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/network/dnslookup/dnslookup)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_NETWORK_DOWNLOAD
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/network/download/download)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_NETWORK_DOWNLOADMANAGER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/network/downloadmanager/downloadmanager)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_NETWORK_FORTUNECLIENT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/network/fortuneclient/fortuneclient)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_NETWORK_FORTUNESERVER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/network/fortuneserver/fortuneserver)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_NETWORK_GOOGLESUGGEST
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/network/googlesuggest/googlesuggest)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_NETWORK_HTTP
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/network/http/http)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_NETWORK_LOOPBACK
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/network/loopback/loopback)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_NETWORK_MULTICASTRECEIVER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/network/multicastreceiver/multicastreceiver)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_NETWORK_MULTICASTSENDER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/network/multicastsender/multicastsender)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_NETWORK_NETWORK_CHAT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/network/network-chat/network-chat)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_NETWORK_SECURESOCKETCLIENT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/network/securesocketclient/securesocketclient)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_NETWORK_THREADEDFORTUNESERVER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/network/threadedfortuneserver/threadedfortuneserver)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_NETWORK_TORRENT
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/network/torrent/icons/edit_add.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/network/torrent/icons/edit_remove.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/network/torrent/icons/stop.png)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/network/torrent/torrent)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTCONNECTIVITY)),)
ifdef PTXCONF_QT5_EXAMPLES_NFC_ANNOTATEDURL
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/nfc/annotatedurl/annotatedurl)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTCONNECTIVITY)),)
ifdef PTXCONF_QT5_EXAMPLES_NFC_QML_CORKBOARD
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/nfc/corkboard/android/AndroidManifest.xml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/nfc/corkboard/icon.png)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/nfc/corkboard/qml_corkboard)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTCONNECTIVITY)),)
ifdef PTXCONF_QT5_EXAMPLES_NFC_NDEFEDITOR
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/nfc/ndefeditor/ndefeditor)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTCONNECTIVITY)),)
ifdef PTXCONF_QT5_EXAMPLES_NFC_QML_POSTER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/nfc/poster/qml_poster)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_OPENGL_2DPAINTING
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/opengl/2dpainting/2dpainting)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_OPENGL_CONTEXTINFO
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/opengl/contextinfo/contextinfo)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_OPENGL_CUBE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/opengl/cube/cube)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_OPENGL_HELLOGL2
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/opengl/hellogl2/hellogl2)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_OPENGL_HELLOGLES3
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/opengl/hellogles3/hellogles3)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_OPENGL_HELLOWINDOW
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/opengl/hellowindow/hellowindow)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_OPENGL_PAINTEDWINDOW
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/opengl/paintedwindow/paintedwindow)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_OPENGL_QOPENGLWIDGET
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/opengl/qopenglwidget/qopenglwidget)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_OPENGL_QOPENGLWINDOW
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/opengl/qopenglwindow/qopenglwindow)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_OPENGL_TEXTURES
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/opengl/textures/textures)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_OPENGL_THREADEDQOPENGLWIDGET
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/opengl/threadedqopenglwidget/threadedqopenglwidget)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTLOCATION)),)
ifdef PTXCONF_QT5_EXAMPLES_POSITIONING_GEOFLICKR
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/positioning/geoflickr/geoflickr)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTLOCATION)),)
ifdef PTXCONF_QT5_EXAMPLES_POSITIONING_LOGFILEPOSITIONSOURCE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/positioning/logfilepositionsource/logfilepositionsource)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTLOCATION)),)
ifdef PTXCONF_QT5_EXAMPLES_POSITIONING_SATELLITEINFO
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/positioning/satelliteinfo/satelliteinfo)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTLOCATION)),)
ifdef PTXCONF_QT5_EXAMPLES_POSITIONING_WEATHERINFO
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/positioning/weatherinfo/icons/README.txt)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/positioning/weatherinfo/weatherinfo)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QML_NETWORKACCESSMANAGERFACTORY
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qml/networkaccessmanagerfactory/networkaccessmanagerfactory)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QML_SHELL
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qml/shell/shell)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QML_XMLHTTPREQUEST
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qml/xmlhttprequest/xmlhttprequest)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QML_REFERENCEEXAMPLES_ADDING
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qml/referenceexamples/adding/adding)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QML_REFERENCEEXAMPLES_ATTACHED
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qml/referenceexamples/attached/attached)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QML_REFERENCEEXAMPLES_BINDING
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qml/referenceexamples/binding/binding)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QML_REFERENCEEXAMPLES_COERCION
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qml/referenceexamples/coercion/coercion)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QML_REFERENCEEXAMPLES_DEFAULT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qml/referenceexamples/default/default)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QML_REFERENCEEXAMPLES_EXTENDED
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qml/referenceexamples/extended/extended)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QML_REFERENCEEXAMPLES_GROUPED
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qml/referenceexamples/grouped/grouped)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QML_REFERENCEEXAMPLES_METHODS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qml/referenceexamples/methods/methods)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QML_REFERENCEEXAMPLES_PROPERTIES
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qml/referenceexamples/properties/properties)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QML_REFERENCEEXAMPLES_SIGNAL
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qml/referenceexamples/signal/signal)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QML_REFERENCEEXAMPLES_VALUESOURCE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qml/referenceexamples/valuesource/valuesource)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QML_TUTORIALS_EXTENDING_QML_CHAPTER1_BASICS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qml/tutorials/extending-qml/chapter1-basics/chapter1-basics)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QML_TUTORIALS_EXTENDING_QML_CHAPTER2_METHODS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qml/tutorials/extending-qml/chapter2-methods/chapter2-methods)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QML_TUTORIALS_EXTENDING_QML_CHAPTER3_BINDINGS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qml/tutorials/extending-qml/chapter3-bindings/chapter3-bindings)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QML_TUTORIALS_EXTENDING_QML_CHAPTER4_CUSTOMPROPERTYTYPES
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qml/tutorials/extending-qml/chapter4-customPropertyTypes/chapter4-customPropertyTypes)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QML_TUTORIALS_EXTENDING_QML_CHAPTER5_LISTPROPERTIES
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qml/tutorials/extending-qml/chapter5-listproperties/chapter5-listproperties)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QML_TUTORIALS_EXTENDING_QML_CHAPTER6_PLUGINS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qml/tutorials/extending-qml/chapter6-plugins/Charts/libchartsplugin.so)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/qml/tutorials/extending-qml/chapter6-plugins/Charts/qmldir)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qml/tutorials/extending-qml/chapter6-plugins/chapter6-plugins)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_QPA_QRASTERWINDOW
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qpa/qrasterwindow/qrasterwindow)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_QPA_WINDOWS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qpa/windows/windows)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_ANAGLYPH_RENDERING
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/anaglyph-rendering/anaglyph-rendering)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_ASSIMP_CPP
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/assimp-cpp/assimp-cpp)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_ASSIMP
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/assimp/assimp)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_AUDIO_VISUALIZER_QML
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/audio-visualizer-qml/audio-visualizer-qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_BASICSHAPES_CPP
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/basicshapes-cpp/basicshapes-cpp)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_BIGMODEL_QML
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/bigmodel-qml/bigmodel-qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_BIGSCENE_CPP
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/bigscene-cpp/bigscene-cpp)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_BIGSCENE_INSTANCED_QML
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/bigscene-instanced-qml/bigscene-instanced-qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_CLIP_PLANES_QML
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/clip-planes-qml/clip-planes-qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_CONTROLS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/controls/controls)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_CPP_EXAMPLE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/cpp_example/cpp_example)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_CUSTOM_MESH_CPP
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/custom-mesh-cpp/custom-mesh-cpp)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_CUSTOM_MESH_QML
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/custom-mesh-qml/custom-mesh-qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_CYLINDER_CPP
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/cylinder-cpp/cylinder-cpp)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_CYLINDER_QML
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/cylinder-qml/cylinder-qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_DEFERRED_RENDERER_CPP
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/deferred-renderer-cpp/deferred-renderer-cpp)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_DEFERRED_RENDERER_QML
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/deferred-renderer-qml/deferred-renderer-qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_DYNAMICSCENE_CPP
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/dynamicscene-cpp/dynamicscene-cpp)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_ENABLED_QML
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/enabled-qml/enabled-qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_GLTF
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/gltf/gltf)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_GOOCH_QML
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/gooch-qml/gooch-qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_INSTANCED_ARRAYS_QML
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/instanced-arrays-qml/instanced-arrays-qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_KEYBOARDINPUT_QML
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/keyboardinput-qml/keyboardinput-qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_LIGHTS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/lights/lights)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_LOADER_QML
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/loader-qml/loader-qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_MATERIALS_CPP
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/materials-cpp/materials-cpp)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_MATERIALS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/materials/materials)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_MOUSEINPUT_QML
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/mouseinput-qml/mouseinput-qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_MULTIVIEWPORT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/multiviewport/multiviewport)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_PICKING_QML
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/picking-qml/picking-qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_PLANETS_QML
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/qt3d/planets-qml/android/AndroidManifest.xml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/qt3d/planets-qml/android/res/drawable-hdpi/icon.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/qt3d/planets-qml/android/res/drawable-ldpi/icon.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/qt3d/planets-qml/android/res/drawable-mdpi/icon.png)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/planets-qml/planets-qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_PLASMA
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/plasma/plasma)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_PLAYGROUND_QML
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/playground-qml/playground-qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_SCENE3D_LOADER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/scene3d-loader/scene3d-loader)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_SCENE3D
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/scene3d/scene3d)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_SHADOW_MAP_QML
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/shadow-map-qml/shadow-map-qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_SIMPLE_CPP
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/simple-cpp/simple-cpp)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_SIMPLE_QML
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/simple-qml/simple-qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_SIMPLE_SHADERS_QML
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/simple-shaders-qml/simple-shaders-qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_SKYBOX
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/skybox/skybox)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_TESSELLATION_MODES
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/tessellation-modes/tessellation-modes)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_TORUS_QML
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/torus-qml/torus-qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_TRANSFORMS_QML
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/transforms-qml/transforms-qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_TRANSPARENCY_QML_SCENE3D
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/transparency-qml-scene3d/transparency-qml-scene3d)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_TRANSPARENCY_QML
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/transparency-qml/transparency-qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_WAVE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/wave/wave)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QT3D)),)
ifdef PTXCONF_QT5_EXAMPLES_QT3D_WIREFRAME
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qt3d/wireframe/wireframe)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_QTCONCURRENT_IMAGESCALING
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qtconcurrent/imagescaling/imagescaling)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_QTCONCURRENT_MAPDEMO
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qtconcurrent/map/mapdemo)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_QTCONCURRENT_PROGRESSDIALOG
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qtconcurrent/progressdialog/progressdialog)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_QTCONCURRENT_RUNFUNCTION
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qtconcurrent/runfunction/runfunction)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_QTCONCURRENT_WORDCOUNT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qtconcurrent/wordcount/wordcount)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_QTESTLIB_TUTORIAL1
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qtestlib/tutorial1/tutorial1)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_QTESTLIB_TUTORIAL2
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qtestlib/tutorial2/tutorial2)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_QTESTLIB_TUTORIAL3
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qtestlib/tutorial3/tutorial3)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_QTESTLIB_TUTORIAL4
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qtestlib/tutorial4/tutorial4)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_QTESTLIB_TUTORIAL5
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qtestlib/tutorial5/tutorial5)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_ANIMATION
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/animation/animation)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_CANVAS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/canvas/canvas)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_DRAGANDDROP
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/draganddrop/draganddrop)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_EMBEDDEDINWIDGETS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/embeddedinwidgets/embeddedinwidgets)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_EXTERNALDRAGANDDROP
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/externaldraganddrop/externaldraganddrop)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_IMAGEELEMENTS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/imageelements/imageelements)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_KEYINTERACTION
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/keyinteraction/keyinteraction)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_MOUSEAREA
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/mousearea/mousearea)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_POSITIONERS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/positioners/positioners)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_QUICK_ACCESSIBILITY
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/quick-accessibility/quick-accessibility)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_RENDERCONTROL
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/rendercontrol/rendercontrol)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_RIGHTTOLEFT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/righttoleft/righttoleft)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_SHADEREFFECTS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/shadereffects/shadereffects)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_TEXT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/text/text)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_TEXTUREPROVIDER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/textureprovider/textureprovider)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_THREADING
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/threading/threading)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_TOUCHINTERACTION
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/touchinteraction/touchinteraction)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_VIEWS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/views/views)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_WINDOW
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/window/resources/icon.icns)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/window/resources/icon.ico)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/window/resources/icon.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/window/resources/icon64.png)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/window/window)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_CUSTOMITEMS_MASKEDMOUSEAREA
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/customitems/maskedmousearea/maskedmousearea)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_CUSTOMITEMS_PROGRESSBAR
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/customitems/progressbar/content/ProgressBar.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/customitems/progressbar/content/background.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/customitems/progressbar/main.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_CUSTOMITEMS_SCROLLBAR
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/customitems/scrollbar/ScrollBar.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/customitems/scrollbar/main.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/customitems/scrollbar/pics/niagara_falls.jpg)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_CUSTOMITEMS_SEARCHBOX
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/customitems/searchbox/SearchBox.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/customitems/searchbox/images/clear.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/customitems/searchbox/images/lineedit-bg-focus.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/customitems/searchbox/images/lineedit-bg.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/customitems/searchbox/main.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_CUSTOMITEMS_SPINNER
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/customitems/spinner/content/Spinner.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/customitems/spinner/content/spinner-bg.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/customitems/spinner/content/spinner-select.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/customitems/spinner/main.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_CUSTOMITEMS_TABWIDGET
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/customitems/tabwidget/TabWidget.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/customitems/tabwidget/main.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_DEMOS_CALQLATR
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/demos/calqlatr/calqlatr)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_DEMOS_CLOCKS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/demos/clocks/clocks)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_DEMOS_MAROON
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/maroon)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_DEMOS_PHOTOSURFACE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/demos/photosurface/photosurface)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/photosurface/resources/icon.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/photosurface/resources/photosurface.icns)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/photosurface/resources/photosurface.ico)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_DEMOS_PHOTOVIEWER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/demos/photoviewer/photoviewer)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_DEMOS_RSSNEWS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/demos/rssnews/rssnews)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_DEMOS_SAMEGAME
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/samegame)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_DEMOS_STOCQT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/demos/stocqt/stocqt)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_DEMOS_TWEETSEARCH
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/demos/tweetsearch/tweetsearch)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_LOCALSTORAGE_LOCALSTORAGE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/localstorage/localstorage/localstorage)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_MODELS_ABSTRACTITEMMODEL
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/models/abstractitemmodel/abstractitemmodel)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_MODELS_OBJECTLISTMODEL
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/models/objectlistmodel/objectlistmodel)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_MODELS_STRINGLISTMODEL
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/models/stringlistmodel/stringlistmodel)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_PARTICLES
	@$(call install_tree, qt5-examples, 0, 0, -, \
		/usr/lib/qt5/examples/quick/particles/images)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_PARTICLES_AFFECTORS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/particles/affectors/affectors)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_PARTICLES_CUSTOMPARTICLE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/particles/customparticle/customparticle)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_PARTICLES_EMITTERS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/particles/emitters/emitters)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_PARTICLES_IMAGEPARTICLE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/particles/imageparticle/imageparticle)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_PARTICLES_SYSTEM
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/particles/system/system)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_QUICKWIDGETS_QQUICKVIEWCOMPARISON
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/quickwidgets/qquickviewcomparison/qquickviewcomparison)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_QUICKWIDGETS_QUICKWIDGET
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/quickwidgets/quickwidget/quickwidget)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_SCENEGRAPH_CUSTOMGEOMETRY
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/scenegraph/customgeometry/customgeometry)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_SCENEGRAPH_GRAPH
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/scenegraph/graph/graph)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_SCENEGRAPH_OPENGLUNDERQML
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/scenegraph/openglunderqml/openglunderqml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_SCENEGRAPH_SGENGINE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/scenegraph/sgengine/sgengine)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_SCENEGRAPH_SIMPLEMATERIAL
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/scenegraph/simplematerial/simplematerial)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_SCENEGRAPH_TEXTUREINSGNODE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/scenegraph/textureinsgnode/textureinsgnode)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_SCENEGRAPH_TEXTUREINTHREAD
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/scenegraph/textureinthread/textureinthread)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_SCENEGRAPH_THREADEDANIMATION
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/scenegraph/threadedanimation/threadedanimation)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_SCENEGRAPH_TWOTEXTUREPROVIDERS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/scenegraph/twotextureproviders/twotextureproviders)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICKCONTROLS_CONTROLS_BASICLAYOUTS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quickcontrols/controls/basiclayouts/basiclayouts)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICKCONTROLS_CONTROLS_CALENDAR
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quickcontrols/controls/calendar/calendar)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICKCONTROLS_CONTROLS_FILESYSTEMBROWSER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quickcontrols/controls/filesystembrowser/filesystembrowser)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICKCONTROLS_CONTROLS_GALLERY
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quickcontrols/controls/gallery/gallery)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICKCONTROLS_CONTROLS_STYLES
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quickcontrols/controls/styles/styles)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICKCONTROLS_CONTROLS_TABLEVIEW
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quickcontrols/controls/tableview/tableview)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICKCONTROLS_CONTROLS_TEXTEDITOR
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quickcontrols/controls/texteditor/texteditor)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICKCONTROLS_CONTROLS_TOUCH
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quickcontrols/controls/touch/images/NOTICE.txt)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quickcontrols/controls/touch/touch)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICKCONTROLS_CONTROLS_UIFORMS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quickcontrols/controls/uiforms/uiforms)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICKCONTROLS_DIALOGS_SYSTEMDIALOGS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quickcontrols/dialogs/systemdialogs/systemdialogs)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICKCONTROLS_EXTRAS_DASHBOARD
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quickcontrols/extras/dashboard/dashboard)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quickcontrols/extras/dashboard/fonts/LICENSE)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICKCONTROLS_EXTRAS_FLAT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quickcontrols/extras/flat/flat)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICKCONTROLS_EXTRAS_GALLERY
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quickcontrols/extras/gallery/fonts/LICENSE.txt)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quickcontrols/extras/gallery/gallery)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICKCONTROLS2_GALLERY
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quickcontrols2/gallery/gallery)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSCRIPT)),)
ifdef PTXCONF_QT5_EXAMPLES_SCRIPT_CALCULATOR
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/script/calculator/calculator)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSCRIPT)),)
ifdef PTXCONF_QT5_EXAMPLES_SCRIPT_CONTEXT2D
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/script/context2d/context2d)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/script/context2d/scripts/alpha.js)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/script/context2d/scripts/arc.js)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/script/context2d/scripts/bezier.js)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/script/context2d/scripts/clock.js)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/script/context2d/scripts/fill1.js)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/script/context2d/scripts/grad.js)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/script/context2d/scripts/linecap.js)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/script/context2d/scripts/linestye.js)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/script/context2d/scripts/moveto.js)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/script/context2d/scripts/moveto2.js)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/script/context2d/scripts/pacman.js)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/script/context2d/scripts/plasma.js)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/script/context2d/scripts/pong.js)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/script/context2d/scripts/quad.js)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/script/context2d/scripts/rgba.js)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/script/context2d/scripts/rotate.js)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/script/context2d/scripts/scale.js)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/script/context2d/scripts/stroke1.js)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/script/context2d/scripts/translate.js)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSCRIPT)),)
ifdef PTXCONF_QT5_EXAMPLES_SCRIPT_CUSTOMCLASS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/script/customclass/customclass)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSCRIPT)),)
ifdef PTXCONF_QT5_EXAMPLES_SCRIPT_DEFAULTPROTOTYPES
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/script/defaultprototypes/defaultprototypes)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSCRIPT)),)
ifdef PTXCONF_QT5_EXAMPLES_SCRIPT_HELLOSCRIPT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/script/helloscript/helloscript)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSCRIPT)),)
ifdef PTXCONF_QT5_EXAMPLES_SCRIPT_MARSHAL
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/script/marshal/marshal)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSCRIPT)),)
ifdef PTXCONF_QT5_EXAMPLES_SCRIPT_QSCRIPT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/script/qscript/qscript)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSCRIPT)),)
ifdef PTXCONF_QT5_EXAMPLES_SCRIPT_QSDBG
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/script/qsdbg/example.js)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/script/qsdbg/qsdbg)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSCRIPT)),)
ifdef PTXCONF_QT5_EXAMPLES_SCRIPT_QSTETRIX
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/script/qstetrix/qstetrix)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSENSORS)),)
ifdef PTXCONF_QT5_EXAMPLES_SENSORS_ACCELBUBBLE
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/sensors/accelbubble/Info.plist)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/sensors/accelbubble/accelbubble)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/sensors/accelbubble/android/AndroidManifest.xml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSENSORS)),)
ifdef PTXCONF_QT5_EXAMPLES_SENSORS_GRUE_APP
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/sensors/grue/Grue/libdeclarative_grue.so)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/sensors/grue/Grue/qmldir)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/sensors/grue/detect_grue)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/sensors/grue/grue.xcf)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/sensors/grue/grue_app)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/sensors/grue/icon.xcf)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/sensors/grue/import/import.json)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/sensors/grue/libgruesensor.prl)
	@$(call install_link, qt5-examples, libgruesensor.so.1.0.0, \
		/usr/lib/qt5/examples/sensors/grue/libgruesensor.so)
	@$(call install_link, qt5-examples, libgruesensor.so.1.0.0, \
		/usr/lib/qt5/examples/sensors/grue/libgruesensor.so.1)
	@$(call install_link, qt5-examples, libgruesensor.so.1.0.0, \
		/usr/lib/qt5/examples/sensors/grue/libgruesensor.so.1.0)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/sensors/grue/libgruesensor.so.1.0.0)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/sensors/grue/plugin/plugin.json)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/sensors/grue/sensors/libqtsensors_grue.so)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSENSORS)),)
ifdef PTXCONF_QT5_EXAMPLES_SENSORS_MAZE
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/sensors/maze/android/AndroidManifest.xml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/sensors/maze/maze)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSENSORS)),)
ifdef PTXCONF_QT5_EXAMPLES_SENSORS_QMLQTSENSORS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/sensors/qmlqtsensors/qmlqtsensors)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSENSORS)),)
ifdef PTXCONF_QT5_EXAMPLES_SENSORS_QMLSENSORGESTURES
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/sensors/qmlsensorgestures/qmlsensorgestures)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSENSORS)),)
ifdef PTXCONF_QT5_EXAMPLES_SENSORS_SENSOR_EXPLORER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/sensors/sensor_explorer/Explorer/libdeclarative_explorer.so)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/sensors/sensor_explorer/Explorer/qmldir)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/sensors/sensor_explorer/import/import.json)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/sensors/sensor_explorer/sensor_explorer)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSENSORS)),)
ifdef PTXCONF_QT5_EXAMPLES_SENSORS_GESTURE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/sensors/sensorgestures/gesture)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSENSORS)),)
ifdef PTXCONF_QT5_EXAMPLES_SENSORS_SHAKEIT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/sensors/shakeit/shakeit)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSERIALBUS)),)
ifdef PTXCONF_QT5_EXAMPLES_SERIALBUS_CAN
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/serialbus/can/can)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSERIALBUS)),)
ifdef PTXCONF_QT5_EXAMPLES_SERIALBUS_MODBUS_ADUEDITOR
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/serialbus/modbus/adueditor/adueditor)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSERIALBUS)),)
ifdef PTXCONF_QT5_EXAMPLES_SERIALBUS_MODBUS_MODBUSMASTER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/serialbus/modbus/master/modbusmaster)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSERIALBUS)),)
ifdef PTXCONF_QT5_EXAMPLES_SERIALBUS_MODBUS_MODBUSSLAVE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/serialbus/modbus/slave/modbusslave)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSERIALPORT)),)
ifdef PTXCONF_QT5_EXAMPLES_SERIALPORT_BLOCKINGMASTER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/serialport/blockingmaster/blockingmaster)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSERIALPORT)),)
ifdef PTXCONF_QT5_EXAMPLES_SERIALPORT_BLOCKINGSLAVE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/serialport/blockingslave/blockingslave)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSERIALPORT)),)
ifdef PTXCONF_QT5_EXAMPLES_SERIALPORT_CENUMERATOR
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/serialport/cenumerator/cenumerator)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSERIALPORT)),)
ifdef PTXCONF_QT5_EXAMPLES_SERIALPORT_CREADERASYNC
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/serialport/creaderasync/creaderasync)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSERIALPORT)),)
ifdef PTXCONF_QT5_EXAMPLES_SERIALPORT_CREADERSYNC
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/serialport/creadersync/creadersync)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSERIALPORT)),)
ifdef PTXCONF_QT5_EXAMPLES_SERIALPORT_CWRITERASYNC
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/serialport/cwriterasync/cwriterasync)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSERIALPORT)),)
ifdef PTXCONF_QT5_EXAMPLES_SERIALPORT_CWRITERSYNC
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/serialport/cwritersync/cwritersync)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSERIALPORT)),)
ifdef PTXCONF_QT5_EXAMPLES_SERIALPORT_ENUMERATOR
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/serialport/enumerator/enumerator)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSERIALPORT)),)
ifdef PTXCONF_QT5_EXAMPLES_SERIALPORT_MASTER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/serialport/master/master)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSERIALPORT)),)
ifdef PTXCONF_QT5_EXAMPLES_SERIALPORT_SLAVE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/serialport/slave/slave)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSERIALPORT)),)
ifdef PTXCONF_QT5_EXAMPLES_SERIALPORT_TERMINAL
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/serialport/terminal/terminal)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_SQL_BOOKS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/sql/books/books)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_SQL_CACHEDTABLE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/sql/cachedtable/cachedtable)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_SQL_DRILLDOWN
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/sql/drilldown/drilldown)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_SQL_MASTERDETAIL
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/sql/masterdetail/albumdetails.xml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/sql/masterdetail/masterdetail)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_SQL_QUERYMODEL
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/sql/querymodel/querymodel)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_SQL_RELATIONALTABLEMODEL
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/sql/relationaltablemodel/relationaltablemodel)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_SQL_SQLWIDGETMAPPER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/sql/sqlwidgetmapper/sqlwidgetmapper)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_SQL_TABLEMODEL
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/sql/tablemodel/tablemodel)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSVG)),)
ifdef PTXCONF_QT5_EXAMPLES_SVG_EMBEDDEDSVGVIEWER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/svg/embeddedsvgviewer/embeddedsvgviewer)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSVG)),)
ifdef PTXCONF_QT5_EXAMPLES_SVG_SVGGENERATOR
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/svg/svggenerator/svggenerator)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSVG)),)
ifdef PTXCONF_QT5_EXAMPLES_SVG_SVGVIEWER
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/svgviewer/files/cubic.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/svgviewer/files/spheres.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/svg/svgviewer/svgviewer)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSVG)),)
ifdef PTXCONF_QT5_EXAMPLES_SVG_DRAGANDDROP_DELAYEDENCODING
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/svg/draganddrop/delayedencoding/delayedencoding)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSVG)),)
ifdef PTXCONF_QT5_EXAMPLES_SVG_EMBEDDED_DESKTOPSERVICES
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/desktopservices/data/Explosion.wav)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/desktopservices/data/designer.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/desktopservices/data/monkey_on_64x64.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/desktopservices/data/sax.mp3)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/svg/embedded/desktopservices/desktopservices)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/desktopservices/resources/heart.svg)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSVG)),)
ifdef PTXCONF_QT5_EXAMPLES_SVG_EMBEDDED_FLUIDLAUNCHER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/svg/embedded/fluidlauncher/fluidlauncher)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSVG)),)
ifdef PTXCONF_QT5_EXAMPLES_SVG_EMBEDDED_WEATHERINFO
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/weatherinfo/icons/README.txt)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/svg/embedded/weatherinfo/weatherinfo)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSVG)),)
ifdef PTXCONF_QT5_EXAMPLES_SVG_NETWORK_BEARERCLOUD
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/svg/network/bearercloud/bearercloud)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSVG)),)
ifdef PTXCONF_QT5_EXAMPLES_SVG_OPENGL_FRAMEBUFFEROBJECT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/svg/opengl/framebufferobject/framebufferobject)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSVG)),)
ifdef PTXCONF_QT5_EXAMPLES_SVG_RICHTEXT_TEXTOBJECT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/svg/richtext/textobject/textobject)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_TOUCH_DIALS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/touch/dials/dials)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_TOUCH_FINGERPAINT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/touch/fingerpaint/fingerpaint)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_TOUCH_KNOBS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/touch/knobs/knobs)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_TOUCH_PINCHZOOM
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/touch/pinchzoom/pinchzoom)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTTOOLS)),)
ifdef PTXCONF_QT5_EXAMPLES_UITOOLS_MULTIPLEINHERITANCE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/uitools/multipleinheritance/multipleinheritance)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTTOOLS)),)
ifdef PTXCONF_QT5_EXAMPLES_UITOOLS_TEXTFINDER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/uitools/textfinder/textfinder)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTWEBCHANNEL)),)
ifdef PTXCONF_QT5_EXAMPLES_WEBCHANNEL_CHATSERVER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/webchannel/chatserver-cpp/chatserver)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTWEBCHANNEL)),)
ifdef PTXCONF_QT5_EXAMPLES_WEBCHANNEL_STANDALONE
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webchannel/standalone/index.html)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webchannel/standalone/qwebchannel.js)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/webchannel/standalone/standalone)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTWEBENGINE)),)
ifdef PTXCONF_QT5_EXAMPLES_WEBENGINE_MINIMAL
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/webengine/minimal/minimal)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTWEBENGINE)),)
ifdef PTXCONF_QT5_EXAMPLES_WEBENGINE_QUICKNANOBROWSER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/webengine/quicknanobrowser/quicknanobrowser)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTWEBENGINE)),)
ifdef PTXCONF_QT5_EXAMPLES_WEBENGINEWIDGETS_CONTENTMANIPULATION
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/webenginewidgets/contentmanipulation/contentmanipulation)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTWEBENGINE)),)
ifdef PTXCONF_QT5_EXAMPLES_WEBENGINEWIDGETS_COOKIEBROWSER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/webenginewidgets/cookiebrowser/cookiebrowser)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTWEBENGINE)),)
ifdef PTXCONF_QT5_EXAMPLES_WEBENGINEWIDGETS_DEMOBROWSER
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webenginewidgets/demobrowser/Info_mac.plist)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/webenginewidgets/demobrowser/demobrowser)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webenginewidgets/demobrowser/demobrowser.icns)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webenginewidgets/demobrowser/demobrowser.ico)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTWEBENGINE)),)
ifdef PTXCONF_QT5_EXAMPLES_WEBENGINEWIDGETS_MARKDOWNEDITOR
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webenginewidgets/markdowneditor/3RDPARTY.md)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/webenginewidgets/markdowneditor/markdowneditor)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTWEBENGINE)),)
ifdef PTXCONF_QT5_EXAMPLES_WEBENGINEWIDGETS_MINIMAL
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/webenginewidgets/minimal/minimal)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTWEBENGINE)),)
ifdef PTXCONF_QT5_EXAMPLES_WEBENGINEWIDGETS_SIMPLEBROWSER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/webenginewidgets/simplebrowser/simplebrowser)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTWEBSOCKETS)),)
ifdef PTXCONF_QT5_EXAMPLES_WEBSOCKETS_ECHOCLIENT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/websockets/echoclient/echoclient)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTWEBSOCKETS)),)
ifdef PTXCONF_QT5_EXAMPLES_WEBSOCKETS_ECHOSERVER
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/websockets/echoserver/echoclient.html)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/websockets/echoserver/echoserver)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTWEBSOCKETS)),)
ifdef PTXCONF_QT5_EXAMPLES_WEBSOCKETS_QMLWEBSOCKETCLIENT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/websockets/qmlwebsocketclient/qmlwebsocketclient)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTWEBSOCKETS)),)
ifdef PTXCONF_QT5_EXAMPLES_WEBSOCKETS_QMLWEBSOCKETSERVER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/websockets/qmlwebsocketserver/qmlwebsocketserver)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTWEBSOCKETS)),)
ifdef PTXCONF_QT5_EXAMPLES_WEBSOCKETS_CHATSERVER
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/websockets/simplechat/chatclient.html)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/websockets/simplechat/chatserver)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTWEBSOCKETS)),)
ifdef PTXCONF_QT5_EXAMPLES_WEBSOCKETS_SSLECHOCLIENT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/websockets/sslechoclient/sslechoclient)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTWEBSOCKETS)),)
ifdef PTXCONF_QT5_EXAMPLES_WEBSOCKETS_SSLECHOSERVER
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/websockets/sslechoserver/sslechoclient.html)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/websockets/sslechoserver/sslechoserver)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTWEBVIEW)),)
ifdef PTXCONF_QT5_EXAMPLES_WEBVIEW_MINIBROWSER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/webview/minibrowser/minibrowser)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_WINDOWCONTAINER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/windowcontainer/windowcontainer)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_ANIMATION_ANIMATEDTILES
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/animation/animatedtiles/animatedtiles)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_ANIMATION_APPCHOOSER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/animation/appchooser/appchooser)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_ANIMATION_EASING
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/animation/easing/easing)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_ANIMATION_MOVEBLOCKS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/animation/moveblocks/moveblocks)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_ANIMATION_STATES
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/animation/states/states)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_ANIMATION_STICKMAN
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/animation/stickman/stickman)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_ANIMATION_SUB_ATTAQ
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/scalable/background-n810.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/scalable/background.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/scalable/bomb.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/scalable/sand.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/scalable/see.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/scalable/sky.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/scalable/surface.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/sub-attaq)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_DESKTOP_SCREENSHOT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/desktop/screenshot/screenshot)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_DESKTOP_SYSTRAY
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/desktop/systray/systray)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_DIALOGS_CLASSWIZARD
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/dialogs/classwizard/classwizard)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_DIALOGS_CONFIGDIALOG
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/dialogs/configdialog/configdialog)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_DIALOGS_EXTENSION
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/dialogs/extension/extension)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_DIALOGS_FINDFILES
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/dialogs/findfiles/findfiles)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_DIALOGS_LICENSEWIZARD
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/dialogs/licensewizard/licensewizard)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_DIALOGS_STANDARDDIALOGS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/dialogs/standarddialogs/standarddialogs)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_DIALOGS_TABDIALOG
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/dialogs/tabdialog/tabdialog)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_DIALOGS_TRIVIALWIZARD
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/dialogs/trivialwizard/trivialwizard)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_DRAGANDDROP_DRAGGABLEICONS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/draganddrop/draggableicons/draggableicons)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_DRAGANDDROP_DRAGGABLETEXT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/draganddrop/draggabletext/draggabletext)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_DRAGANDDROP_DROPSITE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/draganddrop/dropsite/dropsite)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_DRAGANDDROP_FRIDGEMAGNETS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/draganddrop/fridgemagnets/fridgemagnets)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_DRAGANDDROP_PUZZLE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/draganddrop/puzzle/puzzle)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_EFFECTS_BLURPICKER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/effects/blurpicker/blurpicker)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/effects/blurpicker/images/README.txt)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_EFFECTS_FADEMESSAGE
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/effects/fademessage/README)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/effects/fademessage/fademessage)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_EFFECTS_LIGHTING
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/effects/lighting/lighting)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_GESTURES_IMAGEGESTURES
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/gestures/imagegestures/imagegestures)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_GRAPHICSVIEW_ANCHORLAYOUT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/anchorlayout/anchorlayout)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_GRAPHICSVIEW_BASICGRAPHICSLAYOUTS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/basicgraphicslayouts/basicgraphicslayouts)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_GRAPHICSVIEW_BOXES
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/boxes/3rdparty/fbm.c)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/boxes/boxes)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_GRAPHICSVIEW_CHIP
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/chip/chip)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_GRAPHICSVIEW_COLLIDINGMICE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/collidingmice/collidingmice)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_GRAPHICSVIEW_DIAGRAMSCENE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/diagramscene/diagramscene)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_GRAPHICSVIEW_DRAGDROPROBOT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/dragdroprobot/dragdroprobot)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_GRAPHICSVIEW_ELASTICNODES
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/elasticnodes/elasticnodes)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_GRAPHICSVIEW_EMBEDDEDDIALOGS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/embeddeddialogs/embeddeddialogs)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_GRAPHICSVIEW_FLOWLAYOUT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/flowlayout/flowlayout)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_GRAPHICSVIEW_PADNAVIGATOR
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/padnavigator/padnavigator)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_GRAPHICSVIEW_SIMPLEANCHORLAYOUT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/simpleanchorlayout/simpleanchorlayout)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_GRAPHICSVIEW_WEATHERANCHORLAYOUT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/weatheranchorlayout/weatheranchorlayout)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_ITEMVIEWS_ADDRESSBOOK
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/itemviews/addressbook/addressbook)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_ITEMVIEWS_BASICSORTFILTERMODEL
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/itemviews/basicsortfiltermodel/basicsortfiltermodel)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_ITEMVIEWS_CHART
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/itemviews/chart/chart)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_ITEMVIEWS_COLOREDITORFACTORY
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/itemviews/coloreditorfactory/coloreditorfactory)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_ITEMVIEWS_COMBOWIDGETMAPPER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/itemviews/combowidgetmapper/combowidgetmapper)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_ITEMVIEWS_CUSTOMSORTFILTERMODEL
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/itemviews/customsortfiltermodel/customsortfiltermodel)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_ITEMVIEWS_DIRVIEW
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/itemviews/dirview/dirview)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_ITEMVIEWS_EDITABLETREEMODEL
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/itemviews/editabletreemodel/editabletreemodel)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_ITEMVIEWS_FETCHMORE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/itemviews/fetchmore/fetchmore)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_ITEMVIEWS_FROZENCOLUMN
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/itemviews/frozencolumn/frozencolumn)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_ITEMVIEWS_INTERVIEW
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/itemviews/interview/README)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/itemviews/interview/interview)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_ITEMVIEWS_PIXELATOR
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/itemviews/pixelator/pixelator)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_ITEMVIEWS_PUZZLE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/itemviews/puzzle/puzzle)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_ITEMVIEWS_SIMPLEDOMMODEL
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/itemviews/simpledommodel/simpledommodel)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_ITEMVIEWS_SIMPLETREEMODEL
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/itemviews/simpletreemodel/simpletreemodel)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_ITEMVIEWS_SIMPLEWIDGETMAPPER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/itemviews/simplewidgetmapper/simplewidgetmapper)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_ITEMVIEWS_SPINBOXDELEGATE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/itemviews/spinboxdelegate/spinboxdelegate)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_ITEMVIEWS_SPREADSHEET
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/itemviews/spreadsheet/spreadsheet)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_ITEMVIEWS_STARDELEGATE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/itemviews/stardelegate/stardelegate)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_ITEMVIEWS_STORAGEVIEW
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/itemviews/storageview/storageview)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_LAYOUTS_BASICLAYOUTS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/layouts/basiclayouts/basiclayouts)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_LAYOUTS_BORDERLAYOUT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/layouts/borderlayout/borderlayout)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_LAYOUTS_DYNAMICLAYOUTS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/layouts/dynamiclayouts/dynamiclayouts)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_LAYOUTS_FLOWLAYOUT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/layouts/flowlayout/flowlayout)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_MAINWINDOWS_APPLICATION
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/mainwindows/application/application)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_MAINWINDOWS_DOCKWIDGETS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/mainwindows/dockwidgets/dockwidgets)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_MAINWINDOWS_MAINWINDOW
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/mainwindows/mainwindow/mainwindow)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_MAINWINDOWS_MDI
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/mainwindows/mdi/mdi)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_MAINWINDOWS_MENUS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/mainwindows/menus/menus)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_MAINWINDOWS_SDI
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/mainwindows/sdi/sdi)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_PAINTING_AFFINE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/painting/affine/affine)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_PAINTING_BASICDRAWING
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/painting/basicdrawing/basicdrawing)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_PAINTING_COMPOSITION
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/painting/composition/composition)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_PAINTING_CONCENTRICCIRCLES
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/painting/concentriccircles/concentriccircles)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_PAINTING_DEFORM
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/painting/deform/deform)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_PAINTING_FONTSAMPLER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/painting/fontsampler/fontsampler)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_PAINTING_GRADIENTS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/painting/gradients/gradients)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_PAINTING_IMAGECOMPOSITION
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/painting/imagecomposition/imagecomposition)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/painting/imagecomposition/images/background.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/painting/imagecomposition/images/blackrectangle.png)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_PAINTING_PAINTERPATHS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/painting/painterpaths/painterpaths)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_PAINTING_PATHSTROKE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/painting/pathstroke/pathstroke)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_PAINTING_TRANSFORMATIONS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/painting/transformations/transformations)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_RICHTEXT_CALENDAR
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/richtext/calendar/calendar)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_RICHTEXT_ORDERFORM
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/richtext/orderform/orderform)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_RICHTEXT_SYNTAXHIGHLIGHTER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/richtext/syntaxhighlighter/syntaxhighlighter)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_RICHTEXT_TEXTEDIT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/richtext/textedit/textedit)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/richtext/textedit/textedit.qdoc)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_SCROLLER_GRAPHICSVIEW
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/scroller/graphicsview/graphicsview)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_STATEMACHINE_EVENTTRANSITIONS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/statemachine/eventtransitions/eventtransitions)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_STATEMACHINE_FACTORIAL
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/statemachine/factorial/factorial)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_STATEMACHINE_PINGPONG
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/statemachine/pingpong/pingpong)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_STATEMACHINE_ROGUE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/statemachine/rogue/rogue)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_STATEMACHINE_TRAFFICLIGHT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/statemachine/trafficlight/trafficlight)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_STATEMACHINE_TWOWAYBUTTON
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/statemachine/twowaybutton/twowaybutton)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_TUTORIALS_ADDRESSBOOK_PART1
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/tutorials/addressbook/part1/part1)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_TUTORIALS_ADDRESSBOOK_PART2
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/tutorials/addressbook/part2/part2)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_TUTORIALS_ADDRESSBOOK_PART3
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/tutorials/addressbook/part3/part3)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_TUTORIALS_ADDRESSBOOK_PART4
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/tutorials/addressbook/part4/part4)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_TUTORIALS_ADDRESSBOOK_PART5
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/tutorials/addressbook/part5/part5)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_TUTORIALS_ADDRESSBOOK_PART6
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/tutorials/addressbook/part6/part6)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_TUTORIALS_ADDRESSBOOK_PART7
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/tutorials/addressbook/part7/part7)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_TUTORIALS_GETTINGSTARTED_GSQT_PART1
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/tutorials/gettingStarted/gsQt/part1/part1)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_TUTORIALS_GETTINGSTARTED_GSQT_PART2
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/tutorials/gettingStarted/gsQt/part2/part2)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_TUTORIALS_GETTINGSTARTED_GSQT_PART3
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/tutorials/gettingStarted/gsQt/part3/part3)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_TUTORIALS_GETTINGSTARTED_GSQT_PART4
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/tutorials/gettingStarted/gsQt/part4/part4)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_TUTORIALS_GETTINGSTARTED_GSQT_PART5
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/tutorials/gettingStarted/gsQt/part5/part5)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_TUTORIALS_MODELVIEW_MV_READONLY
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/tutorials/modelview/1_readonly/mv_readonly)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_TUTORIALS_MODELVIEW_MV_FORMATTING
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/tutorials/modelview/2_formatting/mv_formatting)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_TUTORIALS_MODELVIEW_MV_CHANGINGMODEL
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/tutorials/modelview/3_changingmodel/mv_changingmodel)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_TUTORIALS_MODELVIEW_MV_HEADERS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/tutorials/modelview/4_headers/mv_headers)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_TUTORIALS_MODELVIEW_MV_EDIT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/tutorials/modelview/5_edit/mv_edit)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_TUTORIALS_MODELVIEW_MV_TREE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/tutorials/modelview/6_treeview/mv_tree)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_TUTORIALS_MODELVIEW_MV_SELECTIONS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/tutorials/modelview/7_selections/mv_selections)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_TUTORIALS_WIDGETS_CHILDWIDGET
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/tutorials/widgets/childwidget/childwidget)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_TUTORIALS_WIDGETS_NESTEDLAYOUTS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/tutorials/widgets/nestedlayouts/nestedlayouts)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_TUTORIALS_WIDGETS_TOPLEVEL
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/tutorials/widgets/toplevel/toplevel)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_TUTORIALS_WIDGETS_WINDOWLAYOUT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/tutorials/widgets/windowlayout/windowlayout)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_WIDGETS_ANALOGCLOCK
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/widgets/analogclock/analogclock)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_WIDGETS_CALCULATOR
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/widgets/calculator/calculator)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_WIDGETS_CALENDARWIDGET
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/widgets/calendarwidget/calendarwidget)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_WIDGETS_CHARACTERMAP
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/widgets/charactermap/charactermap)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_WIDGETS_CODEEDITOR
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/widgets/codeeditor/codeeditor)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_WIDGETS_DIGITALCLOCK
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/widgets/digitalclock/digitalclock)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_WIDGETS_ELIDEDLABEL
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/widgets/elidedlabel/elidedlabel)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_WIDGETS_GROUPBOX
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/widgets/groupbox/groupbox)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_WIDGETS_ICONS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/widgets/icons/icons)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/icons/images/designer.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/icons/images/find_disabled.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/icons/images/find_normal.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/icons/images/monkey_off_128x128.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/icons/images/monkey_off_16x16.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/icons/images/monkey_off_32x32.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/icons/images/monkey_off_64x64.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/icons/images/monkey_on_128x128.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/icons/images/monkey_on_16x16.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/icons/images/monkey_on_32x32.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/icons/images/monkey_on_64x64.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/icons/images/qt_extended_16x16.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/icons/images/qt_extended_32x32.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/icons/images/qt_extended_48x48.png)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_WIDGETS_IMAGEVIEWER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/widgets/imageviewer/imageviewer)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_WIDGETS_LINEEDITS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/widgets/lineedits/lineedits)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_WIDGETS_MOUSEBUTTONS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/widgets/mousebuttons/mousebuttons)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_WIDGETS_MOVIE
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/movie/animation.gif)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/widgets/movie/movie)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_WIDGETS_SCRIBBLE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/widgets/scribble/scribble)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_WIDGETS_SHAPEDCLOCK
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/widgets/shapedclock/shapedclock)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_WIDGETS_SLIDERS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/widgets/sliders/sliders)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_WIDGETS_SPINBOXES
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/widgets/spinboxes/spinboxes)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_WIDGETS_STYLES
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/widgets/styles/styles)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_WIDGETS_STYLESHEET
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/widgets/stylesheet/stylesheet)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_WIDGETS_TABLET
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/widgets/tablet/tablet)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_WIDGETS_TETRIX
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/widgets/tetrix/tetrix)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_WIDGETS_TOOLTIPS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/widgets/tooltips/tooltips)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_WIDGETS_VALIDATORS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/widgets/validators/validators)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_WIDGETS_WIGGLY
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/widgets/wiggly/wiggly)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_WIDGETS_WINDOWFLAGS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/widgets/windowflags/windowflags)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_XML_DOMBOOKMARKS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/xml/dombookmarks/dombookmarks)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/xml/dombookmarks/jennifer.xbel)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_XML_HTMLINFO
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/xml/htmlinfo/htmlinfo)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_XML_RSSLISTING
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/xml/rsslisting/rsslisting)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_XML_SAXBOOKMARKS
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/xml/saxbookmarks/jennifer.xbel)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/xml/saxbookmarks/saxbookmarks)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_XML_STREAMBOOKMARKS
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/xml/streambookmarks/jennifer.xbel)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/xml/streambookmarks/streambookmarks)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_XML_XMLSTREAMLINT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/xml/xmlstreamlint/xmlstreamlint)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_XMLPATTERNS_FILETREE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/xmlpatterns/filetree/filetree)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_XMLPATTERNS_RECIPES
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/xmlpatterns/recipes/recipes)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_XMLPATTERNS_SCHEMA
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/xmlpatterns/schema/schema)
endif
endif

	@$(call install_finish, qt5-examples)
	@$(call touch)

# vim: syntax=make
