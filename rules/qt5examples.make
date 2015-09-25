# WARNING: this file is generated with qt5_mk_examples.sh
# do not edit

# broken on PPC
ifdef PTXCONF_ARCH_PPC
PTXCONF_QT5_MODULE_QTCONNECTIVITY :=
PTXCONF_QT5_MODULE_QTQUICK1 :=
PTXCONF_QT5_MODULE_QTSCRIPT :=
PTXCONF_QT5_MODULE_QTWEBENGINE :=
PTXCONF_QT5_MODULE_QTWEBKIT :=
PTXCONF_QT5_MODULE_QTWEBKIT_EXAMPLES :=
endif
# QtWebEngine needs at least ARMv6
ifdef PTXCONF_ARCH_ARM
ifndef PTXCONF_ARCH_ARM_V6
PTXCONF_QT5_MODULE_QTWEBENGINE :=
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/bluetooth/btfiletransfer/busy.gif)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/bluetooth/btfiletransfer/pairing.gif)
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/bluetooth/chat/Button.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/bluetooth/chat/InputBox.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/bluetooth/chat/Search.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/bluetooth/chat/chat.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/bluetooth/chat/images/clear.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/bluetooth/chat/images/default.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/bluetooth/chat/images/lineedit-bg.png)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTCONNECTIVITY)),)
ifdef PTXCONF_QT5_EXAMPLES_BLUETOOTH_HEARTLISTENER
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/bluetooth/heartlistener/assets/Button.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/bluetooth/heartlistener/assets/Point.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/bluetooth/heartlistener/assets/blue_heart.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/bluetooth/heartlistener/assets/blue_heart_small.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/bluetooth/heartlistener/assets/busy_dark.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/bluetooth/heartlistener/assets/dialog.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/bluetooth/heartlistener/assets/draw.js)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/bluetooth/heartlistener/assets/home.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/bluetooth/heartlistener/assets/main.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/bluetooth/heartlistener/assets/monitor.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/bluetooth/heartlistener/assets/results.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/bluetooth/heartlistener/assets/star.png)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/bluetooth/heartlistener/heartlistener)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTCONNECTIVITY)),)
ifdef PTXCONF_QT5_EXAMPLES_BLUETOOTH_LOWENERGYSCANNER
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/bluetooth/lowenergyscanner/assets/Characteristics.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/bluetooth/lowenergyscanner/assets/Dialog.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/bluetooth/lowenergyscanner/assets/Header.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/bluetooth/lowenergyscanner/assets/Label.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/bluetooth/lowenergyscanner/assets/Menu.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/bluetooth/lowenergyscanner/assets/Services.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/bluetooth/lowenergyscanner/assets/busy_dark.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/bluetooth/lowenergyscanner/assets/main.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/bluetooth/lowenergyscanner/lowenergyscanner)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTCONNECTIVITY)),)
ifdef PTXCONF_QT5_EXAMPLES_BLUETOOTH_QML_PICTURETRANSFER
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/bluetooth/picturetransfer/Button.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/bluetooth/picturetransfer/DeviceDiscovery.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/bluetooth/picturetransfer/FileSending.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/bluetooth/picturetransfer/PictureSelector.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/bluetooth/picturetransfer/background.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/bluetooth/picturetransfer/bttransfer.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTCONNECTIVITY)),)
ifdef PTXCONF_QT5_EXAMPLES_BLUETOOTH_PINGPONG
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/bluetooth/pingpong/assets/Board.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/bluetooth/pingpong/assets/Dialog.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/bluetooth/pingpong/assets/Menu.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/bluetooth/pingpong/assets/main.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/bluetooth/pingpong/pingpong)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTCONNECTIVITY)),)
ifdef PTXCONF_QT5_EXAMPLES_BLUETOOTH_QML_SCANNER
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/bluetooth/scanner/Button.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/bluetooth/scanner/default.png)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/bluetooth/scanner/qml_scanner)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/bluetooth/scanner/scanner.qml)
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
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_CORELIB_TOOLS_CUSTOMTYPESENDING
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
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_FLICKR
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/flickr/flickr)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/flickr/flickr.desktop)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/flickr/flickr.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/flickr/flickr64.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/flickr/flickr80.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/flickr/flickr_harmattan.desktop)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/flickr/qml/flickr/common/Progress.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/flickr/qml/flickr/common/RssModel.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/flickr/qml/flickr/common/ScrollBar.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/flickr/qml/flickr/common/Slider.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/flickr/qml/flickr/common/qmldir)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/flickr/qml/flickr/flickr-90.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/flickr/qml/flickr/flickr.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/flickr/qml/flickr/mobile/Button.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/flickr/qml/flickr/mobile/GridDelegate.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/flickr/qml/flickr/mobile/ImageDetails.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/flickr/qml/flickr/mobile/ListDelegate.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/flickr/qml/flickr/mobile/TitleBar.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/flickr/qml/flickr/mobile/ToolBar.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/flickr/qml/flickr/mobile/images/gloss.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/flickr/qml/flickr/mobile/images/lineedit.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/flickr/qml/flickr/mobile/images/lineedit.sci)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/flickr/qml/flickr/mobile/images/quit.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/flickr/qml/flickr/mobile/images/stripes.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/flickr/qml/flickr/mobile/images/titlebar.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/flickr/qml/flickr/mobile/images/titlebar.sci)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/flickr/qml/flickr/mobile/images/toolbutton.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/flickr/qml/flickr/mobile/images/toolbutton.sci)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_I18N
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/i18n/i18n)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/i18n/i18n.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/i18n/i18n.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/i18n/qml/i18n/base.ts)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/i18n/qml/i18n/i18n.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/i18n/qml/i18n/qml_en_AU.ts)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/i18n/qml/i18n/qml_fr.ts)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_POSITIONERS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/positioners/positioners)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/positioners/positioners.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/positioners/positioners.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/positioners/qml/positioners/Button.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/positioners/qml/positioners/add.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/positioners/qml/positioners/del.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/positioners/qml/positioners/positioners.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_SHADEREFFECTS
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/shadereffects/qml/shadereffects/Curtain.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/shadereffects/qml/shadereffects/CurtainEffect.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/shadereffects/qml/shadereffects/DropShadow.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/shadereffects/qml/shadereffects/DropShadowEffect.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/shadereffects/qml/shadereffects/Grayscale.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/shadereffects/qml/shadereffects/GrayscaleEffect.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/shadereffects/qml/shadereffects/ImageMask.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/shadereffects/qml/shadereffects/ImageMaskEffect.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/shadereffects/qml/shadereffects/RadialWave.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/shadereffects/qml/shadereffects/RadialWaveEffect.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/shadereffects/qml/shadereffects/Water.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/shadereffects/qml/shadereffects/WaterEffect.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/shadereffects/qml/shadereffects/images/Curtain.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/shadereffects/qml/shadereffects/images/DropShadow.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/shadereffects/qml/shadereffects/images/Grayscale.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/shadereffects/qml/shadereffects/images/ImageMask.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/shadereffects/qml/shadereffects/images/RadialWave.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/shadereffects/qml/shadereffects/images/Water.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/shadereffects/qml/shadereffects/images/back.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/shadereffects/qml/shadereffects/images/bg.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/shadereffects/qml/shadereffects/images/desaturate.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/shadereffects/qml/shadereffects/images/drop_shadow.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/shadereffects/qml/shadereffects/images/fabric.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/shadereffects/qml/shadereffects/images/flower.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/shadereffects/qml/shadereffects/images/image1.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/shadereffects/qml/shadereffects/images/image2.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/shadereffects/qml/shadereffects/images/qt-logo.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/shadereffects/qml/shadereffects/images/shader_effects.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/shadereffects/qml/shadereffects/images/sky.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/shadereffects/qml/shadereffects/images/toolbar.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/shadereffects/qml/shadereffects/images/wave.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/shadereffects/qml/shadereffects/main.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/shadereffects/shadereffects)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_SQLLOCALSTORAGE
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/sqllocalstorage/qml/sqllocalstorage/hello.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/sqllocalstorage/sqllocalstorage)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/sqllocalstorage/sqllocalstorage.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/sqllocalstorage/sqllocalstorage64.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/sqllocalstorage/sqllocalstorage80.png)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_ANIMATION_EASING
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/animation/easing/easing)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/animation/easing/easing.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/animation/easing/easing.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/animation/easing/easing.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/animation/easing/qml/easing/content/QuitButton.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/animation/easing/qml/easing/content/quit.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/animation/easing/qml/easing/easing.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_ANIMATION_STATES
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/animation/states/qml/states/qt-logo.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/animation/states/qml/states/states.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/animation/states/qml/states/transitions.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/animation/states/states)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/animation/states/states.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/animation/states/states.svg)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_ANIMATION_BASICS_COLOR_ANIMATION
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/animation/basics/color-animation/color-animation)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/animation/basics/color-animation/color-animation.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/animation/basics/color-animation/color-animation.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/animation/basics/color-animation/qml/color-animation/color-animation.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/animation/basics/color-animation/qml/color-animation/images/face-smile.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/animation/basics/color-animation/qml/color-animation/images/moon.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/animation/basics/color-animation/qml/color-animation/images/shadow.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/animation/basics/color-animation/qml/color-animation/images/star.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/animation/basics/color-animation/qml/color-animation/images/sun.png)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_ANIMATION_BASICS_PROPERTY_ANIMATION
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/animation/basics/property-animation/property-animation)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/animation/basics/property-animation/property-animation.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/animation/basics/property-animation/property-animation.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/animation/basics/property-animation/qml/property-animation/images/face-smile.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/animation/basics/property-animation/qml/property-animation/images/moon.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/animation/basics/property-animation/qml/property-animation/images/shadow.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/animation/basics/property-animation/qml/property-animation/images/star.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/animation/basics/property-animation/qml/property-animation/images/sun.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/animation/basics/property-animation/qml/property-animation/property-animation.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_ANIMATION_BEHAVIORS_BEHAVIOR_EXAMPLE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/animation/behaviors/behavior-example/behavior-example)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/animation/behaviors/behavior-example/behavior-example.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/animation/behaviors/behavior-example/behavior-example.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/animation/behaviors/behavior-example/qml/behaviours/SideRect.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/animation/behaviors/behavior-example/qml/behaviours/behavior-example.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_CPPEXTENSIONS_NETWORKACCESSMANAGERFACTORY
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/cppextensions/networkaccessmanagerfactory/networkaccessmanagerfactory)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/cppextensions/networkaccessmanagerfactory/qml/networkaccessmanagerfactory/view.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_CPPEXTENSIONS_QGRAPHICSLAYOUTS_QGRAPHICSGRIDLAYOUT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/cppextensions/qgraphicslayouts/qgraphicsgridlayout/qgraphicsgridlayout)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/cppextensions/qgraphicslayouts/qgraphicsgridlayout/qml/qgraphicsgridlayout/qgraphicsgridlayout.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_CPPEXTENSIONS_QGRAPHICSLAYOUTS_QGRAPHICSLINEARLAYOUT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/cppextensions/qgraphicslayouts/qgraphicslinearlayout/qgraphicslinearlayout)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/cppextensions/qgraphicslayouts/qgraphicslinearlayout/qml/qgraphicslinearlayout/qgraphicslinearlayout.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_CPPEXTENSIONS_REFERENCEEXAMPLES_ADDING
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/cppextensions/referenceexamples/adding/adding)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/cppextensions/referenceexamples/adding/example.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_CPPEXTENSIONS_REFERENCEEXAMPLES_ATTACHED
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/cppextensions/referenceexamples/attached/attached)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/cppextensions/referenceexamples/attached/example.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_CPPEXTENSIONS_REFERENCEEXAMPLES_BINDING
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/cppextensions/referenceexamples/binding/binding)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/cppextensions/referenceexamples/binding/example.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_CPPEXTENSIONS_REFERENCEEXAMPLES_COERCION
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/cppextensions/referenceexamples/coercion/coercion)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/cppextensions/referenceexamples/coercion/example.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_CPPEXTENSIONS_REFERENCEEXAMPLES_DEFAULT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/cppextensions/referenceexamples/default/default)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/cppextensions/referenceexamples/default/example.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_CPPEXTENSIONS_REFERENCEEXAMPLES_EXTENDED
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/cppextensions/referenceexamples/extended/example.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/cppextensions/referenceexamples/extended/extended)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_CPPEXTENSIONS_REFERENCEEXAMPLES_GROUPED
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/cppextensions/referenceexamples/grouped/example.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/cppextensions/referenceexamples/grouped/grouped)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_CPPEXTENSIONS_REFERENCEEXAMPLES_METHODS
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/cppextensions/referenceexamples/methods/example.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/cppextensions/referenceexamples/methods/methods)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_CPPEXTENSIONS_REFERENCEEXAMPLES_PROPERTIES
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/cppextensions/referenceexamples/properties/example.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/cppextensions/referenceexamples/properties/properties)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_CPPEXTENSIONS_REFERENCEEXAMPLES_SIGNAL
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/cppextensions/referenceexamples/signal/example.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/cppextensions/referenceexamples/signal/signal)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_CPPEXTENSIONS_REFERENCEEXAMPLES_VALUESOURCE
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/cppextensions/referenceexamples/valuesource/example.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/cppextensions/referenceexamples/valuesource/valuesource)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_DEMOS_CALCULATOR
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/demos/calculator/calculator)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/calculator/calculator.desktop)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/calculator/calculator.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/calculator/calculator64.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/calculator/calculator80.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/calculator/calculator_harmattan.desktop)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/calculator/qml/calculator/CalculatorCore/Button.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/calculator/qml/calculator/CalculatorCore/Display.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/calculator/qml/calculator/CalculatorCore/calculator.js)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/calculator/qml/calculator/CalculatorCore/images/button-.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/calculator/qml/calculator/CalculatorCore/images/button-blue.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/calculator/qml/calculator/CalculatorCore/images/button-green.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/calculator/qml/calculator/CalculatorCore/images/button-purple.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/calculator/qml/calculator/CalculatorCore/images/button-red.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/calculator/qml/calculator/CalculatorCore/images/display.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/calculator/qml/calculator/CalculatorCore/qmldir)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/calculator/qml/calculator/calculator.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_DEMOS_MINEHUNT
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/minehunt/README)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/demos/minehunt/minehunt)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/minehunt/qml/minehunt/MinehuntCore/Explosion.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/minehunt/qml/minehunt/MinehuntCore/Tile.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/minehunt/qml/minehunt/MinehuntCore/pics/back.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/minehunt/qml/minehunt/MinehuntCore/pics/background.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/minehunt/qml/minehunt/MinehuntCore/pics/bomb-color.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/minehunt/qml/minehunt/MinehuntCore/pics/bomb.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/minehunt/qml/minehunt/MinehuntCore/pics/face-sad.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/minehunt/qml/minehunt/MinehuntCore/pics/face-smile-big.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/minehunt/qml/minehunt/MinehuntCore/pics/face-smile.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/minehunt/qml/minehunt/MinehuntCore/pics/flag-color.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/minehunt/qml/minehunt/MinehuntCore/pics/flag.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/minehunt/qml/minehunt/MinehuntCore/pics/front.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/minehunt/qml/minehunt/MinehuntCore/pics/quit.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/minehunt/qml/minehunt/MinehuntCore/pics/star.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/minehunt/qml/minehunt/minehunt.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_DEMOS_PHOTOVIEWER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/demos/photoviewer/photoviewer)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/photoviewer/photoviewer.desktop)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/photoviewer/photoviewer.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/photoviewer/photoviewer64.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/photoviewer/photoviewer80.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/photoviewer/photoviewer_harmattan.desktop)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/photoviewer/qml/photoviewer/PhotoViewerCore/AlbumDelegate.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/photoviewer/qml/photoviewer/PhotoViewerCore/BusyIndicator.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/photoviewer/qml/photoviewer/PhotoViewerCore/Button.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/photoviewer/qml/photoviewer/PhotoViewerCore/EditableButton.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/photoviewer/qml/photoviewer/PhotoViewerCore/PhotoDelegate.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/photoviewer/qml/photoviewer/PhotoViewerCore/ProgressBar.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/photoviewer/qml/photoviewer/PhotoViewerCore/RssModel.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/photoviewer/qml/photoviewer/PhotoViewerCore/Tag.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/photoviewer/qml/photoviewer/PhotoViewerCore/images/box-shadow.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/photoviewer/qml/photoviewer/PhotoViewerCore/images/busy.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/photoviewer/qml/photoviewer/PhotoViewerCore/images/cardboard.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/photoviewer/qml/photoviewer/PhotoViewerCore/qmldir)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/photoviewer/qml/photoviewer/PhotoViewerCore/script/script.js)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/photoviewer/qml/photoviewer/i18n/base.ts)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/photoviewer/qml/photoviewer/i18n/qml_fr.qm)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/photoviewer/qml/photoviewer/i18n/qml_fr.ts)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/photoviewer/qml/photoviewer/photoviewer.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_DEMOS_RSSNEWS
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/rssnews/qml/rssnews/content/BusyIndicator.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/rssnews/qml/rssnews/content/CategoryDelegate.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/rssnews/qml/rssnews/content/NewsDelegate.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/rssnews/qml/rssnews/content/RssFeeds.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/rssnews/qml/rssnews/content/ScrollBar.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/rssnews/qml/rssnews/content/images/busy.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/rssnews/qml/rssnews/content/images/scrollbar.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/rssnews/qml/rssnews/rssnews.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/demos/rssnews/rssnews)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/rssnews/rssnews.desktop)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/rssnews/rssnews.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/rssnews/rssnews64.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/rssnews/rssnews80.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/rssnews/rssnews_harmattan.desktop)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_DEMOS_SAMEGAME
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/samegame/qml/samegame/SamegameCore/BoomBlock.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/samegame/qml/samegame/SamegameCore/Button.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/samegame/qml/samegame/SamegameCore/Dialog.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/samegame/qml/samegame/SamegameCore/pics/background.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/samegame/qml/samegame/SamegameCore/pics/blueStar.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/samegame/qml/samegame/SamegameCore/pics/blueStone.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/samegame/qml/samegame/SamegameCore/pics/greenStar.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/samegame/qml/samegame/SamegameCore/pics/greenStone.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/samegame/qml/samegame/SamegameCore/pics/redStar.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/samegame/qml/samegame/SamegameCore/pics/redStone.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/samegame/qml/samegame/SamegameCore/pics/star.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/samegame/qml/samegame/SamegameCore/pics/yellowStone.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/samegame/qml/samegame/SamegameCore/qmldir)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/samegame/qml/samegame/SamegameCore/samegame.js)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/samegame/qml/samegame/highscores/README)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/samegame/qml/samegame/highscores/score_data.xml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/samegame/qml/samegame/highscores/score_style.xsl)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/samegame/qml/samegame/highscores/scores.php)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/samegame/qml/samegame/samegame.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/demos/samegame/samegame)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/samegame/samegame.desktop)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/samegame/samegame.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/samegame/samegame64.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/samegame/samegame80.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/samegame/samegame_harmattan.desktop)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_DEMOS_SNAKE
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/snake/qml/snake/content/Button.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/snake/qml/snake/content/Cookie.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/snake/qml/snake/content/HighScoreModel.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/snake/qml/snake/content/Link.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/snake/qml/snake/content/Skull.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/snake/qml/snake/content/pics/README)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/snake/qml/snake/content/pics/background.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/snake/qml/snake/content/pics/blueStar.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/snake/qml/snake/content/pics/blueStone.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/snake/qml/snake/content/pics/cookie.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/snake/qml/snake/content/pics/eyes.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/snake/qml/snake/content/pics/head.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/snake/qml/snake/content/pics/head.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/snake/qml/snake/content/pics/pause.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/snake/qml/snake/content/pics/redStar.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/snake/qml/snake/content/pics/redStone.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/snake/qml/snake/content/pics/skull.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/snake/qml/snake/content/pics/snake.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/snake/qml/snake/content/pics/star.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/snake/qml/snake/content/pics/stoneShadow.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/snake/qml/snake/content/pics/yellowStar.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/snake/qml/snake/content/pics/yellowStone.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/snake/qml/snake/content/snake.js)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/snake/qml/snake/snake.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/demos/snake/snake)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/snake/snake.desktop)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/snake/snake.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/snake/snake64.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/snake/snake80.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/snake/snake_harmattan.desktop)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_DEMOS_TWITTER
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/twitter/qml/twitter/TwitterCore/Button.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/twitter/qml/twitter/TwitterCore/FatDelegate.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/twitter/qml/twitter/TwitterCore/Input.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/twitter/qml/twitter/TwitterCore/Loading.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/twitter/qml/twitter/TwitterCore/MultiTitleBar.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/twitter/qml/twitter/TwitterCore/RssModel.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/twitter/qml/twitter/TwitterCore/SearchView.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/twitter/qml/twitter/TwitterCore/TitleBar.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/twitter/qml/twitter/TwitterCore/ToolBar.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/twitter/qml/twitter/TwitterCore/UserModel.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/twitter/qml/twitter/TwitterCore/images/gloss.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/twitter/qml/twitter/TwitterCore/images/lineedit.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/twitter/qml/twitter/TwitterCore/images/lineedit.sci)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/twitter/qml/twitter/TwitterCore/images/loading.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/twitter/qml/twitter/TwitterCore/images/quit.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/twitter/qml/twitter/TwitterCore/images/stripes.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/twitter/qml/twitter/TwitterCore/images/titlebar.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/twitter/qml/twitter/TwitterCore/images/titlebar.sci)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/twitter/qml/twitter/TwitterCore/images/toolbutton.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/twitter/qml/twitter/TwitterCore/images/toolbutton.sci)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/twitter/qml/twitter/TwitterCore/qmldir)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/twitter/qml/twitter/twitter.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/demos/twitter/twitter)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/twitter/twitter.desktop)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/twitter/twitter.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/twitter/twitter64.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/twitter/twitter80.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/demos/twitter/twitter_harmattan.desktop)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_IMAGEELEMENTS_BORDERIMAGE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/imageelements/borderimage/borderimage)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/imageelements/borderimage/borderimage.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/imageelements/borderimage/borderimage.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/imageelements/borderimage/qml/borderimage/borderimage.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/imageelements/borderimage/qml/borderimage/content/MyBorderImage.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/imageelements/borderimage/qml/borderimage/content/ShadowRectangle.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/imageelements/borderimage/qml/borderimage/content/bw.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/imageelements/borderimage/qml/borderimage/content/colors-round.sci)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/imageelements/borderimage/qml/borderimage/content/colors-stretch.sci)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/imageelements/borderimage/qml/borderimage/content/colors.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/imageelements/borderimage/qml/borderimage/content/shadow.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/imageelements/borderimage/qml/borderimage/shadows.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_IMAGEELEMENTS_IMAGE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/imageelements/image/image)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/imageelements/image/image.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/imageelements/image/image.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/imageelements/image/qml/image/ImageCell.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/imageelements/image/qml/image/image.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/imageelements/image/qml/image/qt-logo.png)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_IMAGEELEMENTS_SHADOWS
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/imageelements/shadows/qml/shadows/borderimage.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/imageelements/shadows/qml/shadows/content/MyBorderImage.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/imageelements/shadows/qml/shadows/content/ShadowRectangle.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/imageelements/shadows/qml/shadows/content/bw.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/imageelements/shadows/qml/shadows/content/colors-round.sci)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/imageelements/shadows/qml/shadows/content/colors-stretch.sci)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/imageelements/shadows/qml/shadows/content/colors.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/imageelements/shadows/qml/shadows/content/shadow.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/imageelements/shadows/qml/shadows/shadows.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/imageelements/shadows/shadows)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/imageelements/shadows/shadows.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/imageelements/shadows/shadows.svg)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_KEYINTERACTION_FOCUS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/keyinteraction/focus/focus)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/keyinteraction/focus/focus.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/keyinteraction/focus/focus.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/keyinteraction/focus/qml/focus/FocusCore/ContextMenu.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/keyinteraction/focus/qml/focus/FocusCore/GridMenu.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/keyinteraction/focus/qml/focus/FocusCore/ListMenu.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/keyinteraction/focus/qml/focus/FocusCore/ListViewDelegate.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/keyinteraction/focus/qml/focus/FocusCore/images/arrow.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/keyinteraction/focus/qml/focus/FocusCore/images/qt-logo.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/keyinteraction/focus/qml/focus/focus.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_MODELVIEWS_ABSTRACTITEMMODEL
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/modelviews/abstractitemmodel/abstractitemmodel)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/abstractitemmodel/qml/abstractitemmodel/view.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_MODELVIEWS_GRIDVIEW
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/modelviews/gridview/gridview)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/gridview/gridview.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/gridview/gridviewexample.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/gridview/qml/gridview-example/gridview-example.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/gridview/qml/gridview-example/pics/AddressBook_48.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/gridview/qml/gridview-example/pics/AudioPlayer_48.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/gridview/qml/gridview-example/pics/Camera_48.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/gridview/qml/gridview-example/pics/DateBook_48.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/gridview/qml/gridview-example/pics/EMail_48.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/gridview/qml/gridview-example/pics/TodoList_48.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/gridview/qml/gridview-example/pics/VideoPlayer_48.png)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_MODELVIEWS_OBJECTLISTMODEL
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/modelviews/objectlistmodel/objectlistmodel)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/objectlistmodel/qml/objectlistmodel/view.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_MODELVIEWS_PACKAGE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/modelviews/package/package)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/package/qml/package/Delegate.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/package/qml/package/view.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_MODELVIEWS_PARALLAX
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/modelviews/parallax/parallax)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/parallax/parallax.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/parallax/parallax64.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/parallax/parallax80.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/parallax/qml/parallax/Clock.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/parallax/qml/parallax/ParallaxView.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/parallax/qml/parallax/Smiley.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/parallax/qml/parallax/parallax.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/parallax/qml/parallax/pics/background.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/parallax/qml/parallax/pics/face-smile.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/parallax/qml/parallax/pics/home-page.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/parallax/qml/parallax/pics/shadow.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/parallax/qml/parallax/pics/yast-joystick.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/parallax/qml/parallax/pics/yast-wol.png)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_MODELVIEWS_PATHVIEW
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/modelviews/pathview/pathview)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/pathview/pathview.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/pathview/pathview.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/pathview/qml/pathview-example/pathview-example.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/pathview/qml/pathview-example/pics/AddressBook_48.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/pathview/qml/pathview-example/pics/AudioPlayer_48.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/pathview/qml/pathview-example/pics/Camera_48.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/pathview/qml/pathview-example/pics/DateBook_48.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/pathview/qml/pathview-example/pics/EMail_48.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/pathview/qml/pathview-example/pics/TodoList_48.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/pathview/qml/pathview-example/pics/VideoPlayer_48.png)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_MODELVIEWS_STRINGLISTMODEL
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/stringlistmodel/qml/stringlistmodel/view.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/modelviews/stringlistmodel/stringlistmodel)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_MODELVIEWS_VISUALITEMMODEL
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/visualitemmodel/qml/visualitemmodel/visualitemmodel.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/modelviews/visualitemmodel/visualitemmodel)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/visualitemmodel/visualitemmodel.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/visualitemmodel/visualitemmodel.svg)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_MODELVIEWS_LISTVIEW_DYNAMICLIST
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/dynamiclist/dynamiclist)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/dynamiclist/dynamiclist.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/dynamiclist/dynamiclist.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/dynamiclist/qml/dynamic/content/PetsModel.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/dynamiclist/qml/dynamic/content/PressAndHoldButton.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/dynamiclist/qml/dynamic/content/RecipesModel.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/dynamiclist/qml/dynamic/content/TextButton.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/dynamiclist/qml/dynamic/content/pics/arrow-down.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/dynamiclist/qml/dynamic/content/pics/arrow-up.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/dynamiclist/qml/dynamic/content/pics/fruit-salad.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/dynamiclist/qml/dynamic/content/pics/hamburger.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/dynamiclist/qml/dynamic/content/pics/lemonade.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/dynamiclist/qml/dynamic/content/pics/list-delete.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/dynamiclist/qml/dynamic/content/pics/minus-sign.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/dynamiclist/qml/dynamic/content/pics/moreDown.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/dynamiclist/qml/dynamic/content/pics/moreUp.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/dynamiclist/qml/dynamic/content/pics/pancakes.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/dynamiclist/qml/dynamic/content/pics/plus-sign.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/dynamiclist/qml/dynamic/content/pics/vegetable-soup.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/dynamiclist/qml/dynamic/dynamiclist.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/dynamiclist/qml/dynamic/expandingdelegates.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/dynamiclist/qml/dynamic/highlight.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/dynamiclist/qml/dynamic/highlightranges.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/dynamiclist/qml/dynamic/sections.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_MODELVIEWS_LISTVIEW_EXPANDINGDELEGATES
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/expandingdelegates/expandingdelegates)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/expandingdelegates/expandingdelegates.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/expandingdelegates/expandingdelegates.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/expandingdelegates/qml/expandingdelegates/content/PetsModel.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/expandingdelegates/qml/expandingdelegates/content/PressAndHoldButton.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/expandingdelegates/qml/expandingdelegates/content/RecipesModel.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/expandingdelegates/qml/expandingdelegates/content/TextButton.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/expandingdelegates/qml/expandingdelegates/content/pics/arrow-down.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/expandingdelegates/qml/expandingdelegates/content/pics/arrow-up.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/expandingdelegates/qml/expandingdelegates/content/pics/fruit-salad.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/expandingdelegates/qml/expandingdelegates/content/pics/hamburger.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/expandingdelegates/qml/expandingdelegates/content/pics/lemonade.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/expandingdelegates/qml/expandingdelegates/content/pics/list-delete.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/expandingdelegates/qml/expandingdelegates/content/pics/minus-sign.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/expandingdelegates/qml/expandingdelegates/content/pics/moreDown.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/expandingdelegates/qml/expandingdelegates/content/pics/moreUp.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/expandingdelegates/qml/expandingdelegates/content/pics/pancakes.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/expandingdelegates/qml/expandingdelegates/content/pics/plus-sign.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/expandingdelegates/qml/expandingdelegates/content/pics/vegetable-soup.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/expandingdelegates/qml/expandingdelegates/dynamiclist.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/expandingdelegates/qml/expandingdelegates/expandingdelegates.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/expandingdelegates/qml/expandingdelegates/highlight.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/expandingdelegates/qml/expandingdelegates/highlightranges.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/expandingdelegates/qml/expandingdelegates/sections.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_MODELVIEWS_LISTVIEW_HIGHLIGHT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlight/highlight)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlight/highlight.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlight/highlight.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlight/qml/highlight/content/PetsModel.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlight/qml/highlight/content/PressAndHoldButton.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlight/qml/highlight/content/RecipesModel.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlight/qml/highlight/content/TextButton.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlight/qml/highlight/content/pics/arrow-down.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlight/qml/highlight/content/pics/arrow-up.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlight/qml/highlight/content/pics/fruit-salad.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlight/qml/highlight/content/pics/hamburger.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlight/qml/highlight/content/pics/lemonade.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlight/qml/highlight/content/pics/list-delete.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlight/qml/highlight/content/pics/minus-sign.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlight/qml/highlight/content/pics/moreDown.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlight/qml/highlight/content/pics/moreUp.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlight/qml/highlight/content/pics/pancakes.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlight/qml/highlight/content/pics/plus-sign.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlight/qml/highlight/content/pics/vegetable-soup.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlight/qml/highlight/dynamiclist.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlight/qml/highlight/expandingdelegates.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlight/qml/highlight/highlight.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlight/qml/highlight/highlightranges.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlight/qml/highlight/sections.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_MODELVIEWS_LISTVIEW_HIGHLIGHTRANGES
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlightranges/highlightranges)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlightranges/highlightranges.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlightranges/highlightranges.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlightranges/qml/highlightranges/content/PetsModel.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlightranges/qml/highlightranges/content/PressAndHoldButton.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlightranges/qml/highlightranges/content/RecipesModel.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlightranges/qml/highlightranges/content/TextButton.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlightranges/qml/highlightranges/content/pics/arrow-down.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlightranges/qml/highlightranges/content/pics/arrow-up.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlightranges/qml/highlightranges/content/pics/fruit-salad.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlightranges/qml/highlightranges/content/pics/hamburger.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlightranges/qml/highlightranges/content/pics/lemonade.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlightranges/qml/highlightranges/content/pics/list-delete.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlightranges/qml/highlightranges/content/pics/minus-sign.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlightranges/qml/highlightranges/content/pics/moreDown.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlightranges/qml/highlightranges/content/pics/moreUp.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlightranges/qml/highlightranges/content/pics/pancakes.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlightranges/qml/highlightranges/content/pics/plus-sign.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlightranges/qml/highlightranges/content/pics/vegetable-soup.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlightranges/qml/highlightranges/dynamiclist.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlightranges/qml/highlightranges/expandingdelegates.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlightranges/qml/highlightranges/highlight.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlightranges/qml/highlightranges/highlightranges.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/highlightranges/qml/highlightranges/sections.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_MODELVIEWS_LISTVIEW_SECTIONS
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/sections/qml/sections/content/PetsModel.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/sections/qml/sections/content/PressAndHoldButton.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/sections/qml/sections/content/RecipesModel.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/sections/qml/sections/content/TextButton.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/sections/qml/sections/content/pics/arrow-down.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/sections/qml/sections/content/pics/arrow-up.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/sections/qml/sections/content/pics/fruit-salad.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/sections/qml/sections/content/pics/hamburger.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/sections/qml/sections/content/pics/lemonade.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/sections/qml/sections/content/pics/list-delete.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/sections/qml/sections/content/pics/minus-sign.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/sections/qml/sections/content/pics/moreDown.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/sections/qml/sections/content/pics/moreUp.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/sections/qml/sections/content/pics/pancakes.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/sections/qml/sections/content/pics/plus-sign.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/sections/qml/sections/content/pics/vegetable-soup.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/sections/qml/sections/dynamiclist.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/sections/qml/sections/expandingdelegates.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/sections/qml/sections/highlight.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/sections/qml/sections/highlightranges.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/sections/qml/sections/sections.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/sections/sections)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/sections/sections.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/modelviews/listview/sections/sections.svg)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_RIGHTTOLEFT_LAYOUTDIRECTION
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/righttoleft/layoutdirection/layoutdirection)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/righttoleft/layoutdirection/layoutdirection.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/righttoleft/layoutdirection/layoutdirection64.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/righttoleft/layoutdirection/layoutdirection80.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/righttoleft/layoutdirection/qml/layoutdirection/layoutdirection.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_RIGHTTOLEFT_LAYOUTMIRRORING
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/righttoleft/layoutmirroring/layoutmirroring)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/righttoleft/layoutmirroring/layoutmirroring.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/righttoleft/layoutmirroring/layoutmirroring64.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/righttoleft/layoutmirroring/layoutmirroring80.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/righttoleft/layoutmirroring/qml/layoutmirroring/layoutmirroring.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_RIGHTTOLEFT_TEXTALIGNMENT
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/righttoleft/textalignment/qml/textalignment/textalignment.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/righttoleft/textalignment/textalignment)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/righttoleft/textalignment/textalignment.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/righttoleft/textalignment/textalignment64.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/righttoleft/textalignment/textalignment80.png)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_TEXT_TEXTSELECTION
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/text/textselection/qml/textselection/pics/endHandle.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/text/textselection/qml/textselection/pics/endHandle.sci)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/text/textselection/qml/textselection/pics/startHandle.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/text/textselection/qml/textselection/pics/startHandle.sci)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/text/textselection/qml/textselection/textselection.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/text/textselection/textselection)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/text/textselection/textselection.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/text/textselection/textselection.svg)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_TEXT_FONTS_AVAILABLEFONTS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/text/fonts/availableFonts/availableFonts)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/text/fonts/availableFonts/availableFonts.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/text/fonts/availableFonts/availableFonts.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/text/fonts/availableFonts/qml/availableFonts/availableFonts.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/text/fonts/availableFonts/qml/availableFonts/banner.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/text/fonts/availableFonts/qml/availableFonts/fonts.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/text/fonts/availableFonts/qml/availableFonts/fonts/tarzeau_ocr_a.ttf)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/text/fonts/availableFonts/qml/availableFonts/hello.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_TEXT_FONTS_BANNER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/text/fonts/banner/banner)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/text/fonts/banner/banner.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/text/fonts/banner/banner.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/text/fonts/banner/qml/banner/availableFonts.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/text/fonts/banner/qml/banner/banner.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/text/fonts/banner/qml/banner/fonts.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/text/fonts/banner/qml/banner/fonts/tarzeau_ocr_a.ttf)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/text/fonts/banner/qml/banner/hello.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_TEXT_FONTS_FONTS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/text/fonts/fonts/fonts)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/text/fonts/fonts/fonts.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/text/fonts/fonts/fonts.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/text/fonts/fonts/qml/fonts-qml/availableFonts.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/text/fonts/fonts/qml/fonts-qml/banner.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/text/fonts/fonts/qml/fonts-qml/fonts.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/text/fonts/fonts/qml/fonts-qml/fonts/tarzeau_ocr_a.ttf)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/text/fonts/fonts/qml/fonts-qml/hello.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_TEXT_FONTS_HELLO
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/text/fonts/hello/hello)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/text/fonts/hello/hello.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/text/fonts/hello/hello.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/text/fonts/hello/qml/hello/availableFonts.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/text/fonts/hello/qml/hello/banner.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/text/fonts/hello/qml/hello/fonts.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/text/fonts/hello/qml/hello/fonts/tarzeau_ocr_a.ttf)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/text/fonts/hello/qml/hello/hello.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_THREADING_THREADEDLISTMODEL
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/threading/threadedlistmodel/qml/threadedlistmodel/dataloader.js)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/threading/threadedlistmodel/qml/threadedlistmodel/timedisplay.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/threading/threadedlistmodel/threadedlistmodel)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/threading/threadedlistmodel/threadedlistmodel.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/threading/threadedlistmodel/threadedlistmodel64.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/threading/threadedlistmodel/threadedlistmodel80.png)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_THREADING_WORKERSCRIPT
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/threading/workerscript/qml/workerscript/workerscript.js)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/threading/workerscript/qml/workerscript/workerscript.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/threading/workerscript/workerscript)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/threading/workerscript/workerscript.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/threading/workerscript/workerscript64.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/threading/workerscript/workerscript80.png)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_TOUCHINTERACTION_PINCHAREA
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/touchinteraction/pincharea/pincharea)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/touchinteraction/pincharea/pincharea.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/touchinteraction/pincharea/pincharea64.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/touchinteraction/pincharea/pincharea80.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/touchinteraction/pincharea/qml/pincharea/flickresize.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/touchinteraction/pincharea/qml/pincharea/qt-logo.jpg)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_TOUCHINTERACTION_GESTURES_EXPERIMENTAL_GESTURES
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/touchinteraction/gestures/experimental-gestures/experimental-gestures)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/touchinteraction/gestures/experimental-gestures/experimentalgestures.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/touchinteraction/gestures/experimental-gestures/experimentalgestures.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/touchinteraction/gestures/experimental-gestures/qml/experimental-gestures/experimental-gestures.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_TOUCHINTERACTION_MOUSEAREA_MOUSEAREA_EXAMPLE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/touchinteraction/mousearea/mousearea-example/mousearea-example)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/touchinteraction/mousearea/mousearea-example/mouseareaexample.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/touchinteraction/mousearea/mousearea-example/mouseareaexample.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/touchinteraction/mousearea/mousearea-example/qml/mousearea-example/mousearea-example.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_TOYS_CLOCKS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/toys/clocks/clocks)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/clocks/clocks.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/clocks/clocks.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/clocks/qml/clocks/clocks.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/clocks/qml/clocks/content/Clock.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/clocks/qml/clocks/content/QuitButton.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/clocks/qml/clocks/content/background.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/clocks/qml/clocks/content/center.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/clocks/qml/clocks/content/clock-night.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/clocks/qml/clocks/content/clock.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/clocks/qml/clocks/content/hour.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/clocks/qml/clocks/content/minute.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/clocks/qml/clocks/content/quit.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/clocks/qml/clocks/content/second.png)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_TOYS_CORKBOARDS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/toys/corkboards/corkboards)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/corkboards/corkboards.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/corkboards/corkboards.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/corkboards/qml/corkboards/Day.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/corkboards/qml/corkboards/cork.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/corkboards/qml/corkboards/corkboards.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/corkboards/qml/corkboards/note-yellow.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/corkboards/qml/corkboards/tack.png)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_TOYS_DYNAMICSCENE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/toys/dynamicscene/dynamicscene)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/dynamicscene/dynamicscene.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/dynamicscene/dynamicscene.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/dynamicscene/qml/dynamicscene/Button.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/dynamicscene/qml/dynamicscene/GenericSceneItem.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/dynamicscene/qml/dynamicscene/PaletteItem.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/dynamicscene/qml/dynamicscene/PerspectiveItem.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/dynamicscene/qml/dynamicscene/Sun.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/dynamicscene/qml/dynamicscene/dynamicscene.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/dynamicscene/qml/dynamicscene/images/NOTE)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/dynamicscene/qml/dynamicscene/images/face-smile.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/dynamicscene/qml/dynamicscene/images/moon.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/dynamicscene/qml/dynamicscene/images/rabbit_brown.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/dynamicscene/qml/dynamicscene/images/rabbit_bw.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/dynamicscene/qml/dynamicscene/images/star.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/dynamicscene/qml/dynamicscene/images/sun.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/dynamicscene/qml/dynamicscene/images/tree_s.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/dynamicscene/qml/dynamicscene/itemCreation.js)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_TOYS_TIC_TAC_TOE
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/tic-tac-toe/qml/tic-tac-toe/content/Button.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/tic-tac-toe/qml/tic-tac-toe/content/TicTac.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/tic-tac-toe/qml/tic-tac-toe/content/pics/board.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/tic-tac-toe/qml/tic-tac-toe/content/pics/o.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/tic-tac-toe/qml/tic-tac-toe/content/pics/x.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/tic-tac-toe/qml/tic-tac-toe/content/tic-tac-toe.js)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/tic-tac-toe/qml/tic-tac-toe/tic-tac-toe.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/toys/tic-tac-toe/tic-tac-toe)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/tic-tac-toe/tictactoe.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/tic-tac-toe/tictactoe.svg)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_TOYS_TVTENNIS
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/tvtennis/qml/tvtennis/tvtennis.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/toys/tvtennis/tvtennis)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/tvtennis/tvtennis.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/toys/tvtennis/tvtennis.svg)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_TUTORIALS_EXTENDING_CHAPTER1_BASICS
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/tutorials/extending/chapter1-basics/app.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/tutorials/extending/chapter1-basics/chapter1-basics)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_TUTORIALS_EXTENDING_CHAPTER2_METHODS
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/tutorials/extending/chapter2-methods/app.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/tutorials/extending/chapter2-methods/chapter2-methods)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_TUTORIALS_EXTENDING_CHAPTER3_BINDINGS
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/tutorials/extending/chapter3-bindings/app.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/tutorials/extending/chapter3-bindings/chapter3-bindings)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_TUTORIALS_EXTENDING_CHAPTER4_CUSTOMPROPERTYTYPES
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/tutorials/extending/chapter4-customPropertyTypes/app.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/tutorials/extending/chapter4-customPropertyTypes/chapter4-customPropertyTypes)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_TUTORIALS_EXTENDING_CHAPTER5_LISTPROPERTIES
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/tutorials/extending/chapter5-listproperties/app.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/tutorials/extending/chapter5-listproperties/chapter5-listproperties)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_UI_COMPONENTS_DIALCONTROL
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/ui-components/dialcontrol/dialcontrol)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/dialcontrol/dialcontrol.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/dialcontrol/dialcontrol.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/dialcontrol/qml/dialcontrol/content/Dial.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/dialcontrol/qml/dialcontrol/content/QuitButton.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/dialcontrol/qml/dialcontrol/content/background.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/dialcontrol/qml/dialcontrol/content/needle.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/dialcontrol/qml/dialcontrol/content/needle_shadow.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/dialcontrol/qml/dialcontrol/content/overlay.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/dialcontrol/qml/dialcontrol/content/quit.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/dialcontrol/qml/dialcontrol/dialcontrol.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_UI_COMPONENTS_FLIPABLE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/ui-components/flipable/flipable)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/flipable/flipable.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/flipable/flipable.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/flipable/qml/flipable/content/5_heart.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/flipable/qml/flipable/content/9_club.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/flipable/qml/flipable/content/Card.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/flipable/qml/flipable/content/back.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/flipable/qml/flipable/flipable.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_UI_COMPONENTS_MAIN
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/ui-components/main/main)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/main/main.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/main/main.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/main/qml/main/ScrollBar.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/main/qml/main/SearchBox.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/main/qml/main/TabWidget.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/main/qml/main/content/ProgressBar.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/main/qml/main/content/Spinner.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/main/qml/main/content/background.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/main/qml/main/content/spinner-bg.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/main/qml/main/content/spinner-select.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/main/qml/main/images/clear.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/main/qml/main/images/lineedit-bg-focus.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/main/qml/main/images/lineedit-bg.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/main/qml/main/main.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/main/qml/main/pics/niagara_falls.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/main/qml/main/tab.png)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_UI_COMPONENTS_PROGRESSBAR
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/ui-components/progressbar/progressbar)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/progressbar/progressbar.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/progressbar/progressbar.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/progressbar/qml/progressbar/content/ProgressBar.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/progressbar/qml/progressbar/content/background.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/progressbar/qml/progressbar/main.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_UI_COMPONENTS_SCROLLBAR
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/scrollbar/qml/scrollbar/ScrollBar.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/scrollbar/qml/scrollbar/main.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/scrollbar/qml/scrollbar/niagara_falls.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/ui-components/scrollbar/scrollbar)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/scrollbar/scrollbar.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/scrollbar/scrollbar64.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/scrollbar/scrollbar80.png)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_UI_COMPONENTS_SEARCHBOX
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/searchbox/qml/searchbox/SearchBox.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/searchbox/qml/searchbox/images/clear.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/searchbox/qml/searchbox/images/lineedit-bg-focus.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/searchbox/qml/searchbox/images/lineedit-bg.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/searchbox/qml/searchbox/main.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/ui-components/searchbox/searchbox)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/searchbox/searchbox.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/searchbox/searchbox64.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/searchbox/searchbox80.png)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_UI_COMPONENTS_SLIDESWITCH
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/slideswitch/qml/slideswitch/content/Switch.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/slideswitch/qml/slideswitch/content/background.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/slideswitch/qml/slideswitch/content/knob.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/slideswitch/qml/slideswitch/slideswitch.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/ui-components/slideswitch/slideswitch)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/slideswitch/slideswitch.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/slideswitch/slideswitch.svg)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_UI_COMPONENTS_SPINNER
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/spinner/qml/spinner/content/Spinner.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/spinner/qml/spinner/content/spinner-bg.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/spinner/qml/spinner/content/spinner-select.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/spinner/qml/spinner/main.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/ui-components/spinner/spinner)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/spinner/spinner.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/spinner/spinner64.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/spinner/spinner80.png)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTQUICK1)),)
ifdef PTXCONF_QT5_EXAMPLES_DECLARATIVE_UI_COMPONENTS_TABWIDGET
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/tabwidget/qml/tabwidget/TabWidget.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/tabwidget/qml/tabwidget/main.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/tabwidget/qml/tabwidget/tab.png)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/declarative/ui-components/tabwidget/tabwidget)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/tabwidget/tabwidget.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/tabwidget/tabwidget64.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/declarative/ui-components/tabwidget/tabwidget80.png)
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/enginio/quick/image-gallery/image-gallery.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTENGINIO)),)
ifdef PTXCONF_QT5_EXAMPLES_ENGINIO_QUICK_SOCIALTODOS
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/enginio/quick/socialtodos/Header.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/enginio/quick/socialtodos/List.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/enginio/quick/socialtodos/Login.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/enginio/quick/socialtodos/ShareDialog.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/enginio/quick/socialtodos/TextField.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/enginio/quick/socialtodos/TodoLists.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/enginio/quick/socialtodos/TouchButton.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/enginio/quick/socialtodos/socialtodos.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTENGINIO)),)
ifdef PTXCONF_QT5_EXAMPLES_ENGINIO_QUICK_TODOS
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/enginio/quick/todos/todo.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTENGINIO)),)
ifdef PTXCONF_QT5_EXAMPLES_ENGINIO_QUICK_USERS
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/enginio/quick/users/Browse.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/enginio/quick/users/Login.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/enginio/quick/users/Register.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/enginio/quick/users/users.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTENGINIO)),)
ifdef PTXCONF_QT5_EXAMPLES_ENGINIO_WIDGETS_CLOUDADDRESSBOOK
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTENGINIO)),)
ifdef PTXCONF_QT5_EXAMPLES_ENGINIO_WIDGETS_IMAGE_GALLERY
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTENGINIO)),)
ifdef PTXCONF_QT5_EXAMPLES_ENGINIO_WIDGETS_TODOS
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/gui/openglwindow/openglwindow.pri)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_GUI_RASTERWINDOW
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/gui/rasterwindow/rasterwindow)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/gui/rasterwindow/rasterwindow.pri)
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/linguist/trollprint/trollprint_pt.ts)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTLOCATION)),)
ifdef PTXCONF_QT5_EXAMPLES_LOCATION_QML_LOCATION_MAPVIEWER
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/location/mapviewer/content/dialogs/Message.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/location/mapviewer/content/dialogs/RouteDialog.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/location/mapviewer/content/map/3dItem.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/location/mapviewer/content/map/CircleItem.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/location/mapviewer/content/map/ImageItem.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/location/mapviewer/content/map/MapComponent.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/location/mapviewer/content/map/Marker.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/location/mapviewer/content/map/MiniMap.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/location/mapviewer/content/map/PolygonItem.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/location/mapviewer/content/map/PolylineItem.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/location/mapviewer/content/map/RectangleItem.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/location/mapviewer/content/map/VideoItem.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/location/mapviewer/demo.ogv)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/location/mapviewer/icon.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/location/mapviewer/mapviewer.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/location/mapviewer/qml_location_mapviewer)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTLOCATION)),)
ifdef PTXCONF_QT5_EXAMPLES_LOCATION_QML_LOCATION_PLACES
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/location/places/content/places/CategoryDelegate.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/location/places/content/places/CategoryDialog.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/location/places/content/places/CategoryView.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/location/places/content/places/EditorialDelegate.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/location/places/content/places/EditorialPage.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/location/places/content/places/Group.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/location/places/content/places/MapComponent.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/location/places/content/places/OptionsDialog.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/location/places/content/places/PlaceDelegate.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/location/places/content/places/PlaceDialog.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/location/places/content/places/PlaceEditorials.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/location/places/content/places/PlaceImages.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/location/places/content/places/PlaceReviews.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/location/places/content/places/PlacesUtils.js)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/location/places/content/places/RatingView.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/location/places/content/places/ReviewDelegate.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/location/places/content/places/ReviewPage.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/location/places/content/places/SearchBox.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/location/places/content/places/SearchResultDelegate.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/location/places/content/places/SearchResultView.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/location/places/places.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/location/places/qml_location_places)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTLOCATION)),)
ifdef PTXCONF_QT5_EXAMPLES_LOCATION_PLACES_LIST
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/location/places_list/places_list)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/location/places_list/places_list.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTLOCATION)),)
ifdef PTXCONF_QT5_EXAMPLES_LOCATION_PLACES_MAP
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/location/places_map/marker.png)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/location/places_map/places_map)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/location/places_map/places_map.qml)
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
		/usr/lib/qt5/examples/multimedia/declarative-camera/CameraButton.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/declarative-camera/CameraListButton.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/declarative-camera/CameraListPopup.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/declarative-camera/CameraPropertyButton.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/declarative-camera/CameraPropertyPopup.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/declarative-camera/FocusButton.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/declarative-camera/PhotoCaptureControls.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/declarative-camera/PhotoPreview.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/declarative-camera/Popup.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/declarative-camera/VideoCaptureControls.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/declarative-camera/VideoPreview.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/declarative-camera/ZoomControl.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/multimedia/declarative-camera/declarative-camera)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/declarative-camera/declarative-camera.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/declarative-camera/images/camera_auto_mode.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/declarative-camera/images/camera_camera_setting.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/declarative-camera/images/camera_flash_auto.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/declarative-camera/images/camera_flash_fill.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/declarative-camera/images/camera_flash_off.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/declarative-camera/images/camera_flash_redeye.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/declarative-camera/images/camera_white_balance_cloudy.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/declarative-camera/images/camera_white_balance_flourescent.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/declarative-camera/images/camera_white_balance_incandescent.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/declarative-camera/images/camera_white_balance_sunny.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/declarative-camera/images/toolbutton.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/declarative-camera/images/toolbutton.sci)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTMULTIMEDIA)),)
ifdef PTXCONF_QT5_EXAMPLES_MULTIMEDIA_DECLARATIVE_RADIO
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/multimedia/declarative-radio/declarative-radio)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/declarative-radio/view.qml)
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/images/folder.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/images/leaves.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/images/up.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qml/qmlvideo/Button.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qml/qmlvideo/CameraBasic.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qml/qmlvideo/CameraDrag.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qml/qmlvideo/CameraDummy.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qml/qmlvideo/CameraFullScreen.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qml/qmlvideo/CameraFullScreenInverted.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qml/qmlvideo/CameraItem.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qml/qmlvideo/CameraMove.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qml/qmlvideo/CameraOverlay.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qml/qmlvideo/CameraResize.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qml/qmlvideo/CameraRotate.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qml/qmlvideo/CameraSpin.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qml/qmlvideo/Content.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qml/qmlvideo/ErrorDialog.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qml/qmlvideo/FileBrowser.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qml/qmlvideo/Scene.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qml/qmlvideo/SceneBasic.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qml/qmlvideo/SceneDrag.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qml/qmlvideo/SceneFullScreen.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qml/qmlvideo/SceneFullScreenInverted.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qml/qmlvideo/SceneMove.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qml/qmlvideo/SceneMulti.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qml/qmlvideo/SceneOverlay.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qml/qmlvideo/SceneResize.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qml/qmlvideo/SceneRotate.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qml/qmlvideo/SceneSelectionPanel.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qml/qmlvideo/SceneSpin.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qml/qmlvideo/SeekControl.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qml/qmlvideo/VideoBasic.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qml/qmlvideo/VideoDrag.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qml/qmlvideo/VideoDummy.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qml/qmlvideo/VideoFillMode.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qml/qmlvideo/VideoFullScreen.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qml/qmlvideo/VideoFullScreenInverted.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qml/qmlvideo/VideoItem.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qml/qmlvideo/VideoMetadata.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qml/qmlvideo/VideoMove.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qml/qmlvideo/VideoOverlay.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qml/qmlvideo/VideoPlaybackRate.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qml/qmlvideo/VideoResize.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qml/qmlvideo/VideoRotate.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qml/qmlvideo/VideoSeek.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qml/qmlvideo/VideoSpin.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qml/qmlvideo/main.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideo/qmlvideo)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTMULTIMEDIA)),)
ifdef PTXCONF_QT5_EXAMPLES_MULTIMEDIA_VIDEO_QMLVIDEOFX
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/images/Dropdown_arrows.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/images/Slider_bar.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/images/Slider_handle.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/images/Triangle_Top.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/images/Triangle_bottom.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/images/icon_BackArrow.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/images/icon_Folder.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/images/icon_Menu.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/images/qt-logo.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/qml/qmlvideofx/Button.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/qml/qmlvideofx/Content.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/qml/qmlvideofx/ContentCamera.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/qml/qmlvideofx/ContentImage.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/qml/qmlvideofx/ContentVideo.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/qml/qmlvideofx/Curtain.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/qml/qmlvideofx/Divider.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/qml/qmlvideofx/Effect.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/qml/qmlvideofx/EffectBillboard.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/qml/qmlvideofx/EffectBlackAndWhite.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/qml/qmlvideofx/EffectEmboss.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/qml/qmlvideofx/EffectGaussianBlur.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/qml/qmlvideofx/EffectGlow.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/qml/qmlvideofx/EffectIsolate.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/qml/qmlvideofx/EffectMagnify.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/qml/qmlvideofx/EffectPageCurl.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/qml/qmlvideofx/EffectPassThrough.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/qml/qmlvideofx/EffectPixelate.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/qml/qmlvideofx/EffectPosterize.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/qml/qmlvideofx/EffectRipple.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/qml/qmlvideofx/EffectSelectionList.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/qml/qmlvideofx/EffectSepia.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/qml/qmlvideofx/EffectSharpen.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/qml/qmlvideofx/EffectShockwave.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/qml/qmlvideofx/EffectSobelEdgeDetection1.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/qml/qmlvideofx/EffectTiltShift.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/qml/qmlvideofx/EffectToon.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/qml/qmlvideofx/EffectVignette.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/qml/qmlvideofx/EffectWarhol.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/qml/qmlvideofx/EffectWobble.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/qml/qmlvideofx/FileBrowser.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/qml/qmlvideofx/FileOpen.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/qml/qmlvideofx/HintedMouseArea.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/qml/qmlvideofx/Main.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/qml/qmlvideofx/ParameterPanel.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/qml/qmlvideofx/Slider.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/qmlvideofx)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/shaders/billboard.fsh)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/shaders/blackandwhite.fsh)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/shaders/emboss.fsh)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/shaders/gaussianblur_h.fsh)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/shaders/gaussianblur_v.fsh)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/shaders/glow.fsh)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/shaders/isolate.fsh)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/shaders/magnify.fsh)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/shaders/pagecurl.fsh)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/shaders/pixelate.fsh)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/shaders/posterize.fsh)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/shaders/ripple.fsh)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/shaders/selectionpanel.fsh)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/shaders/sepia.fsh)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/shaders/sharpen.fsh)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/shaders/shockwave.fsh)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/shaders/sobeledgedetection1.fsh)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/shaders/tiltshift.fsh)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/shaders/toon.fsh)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/shaders/vignette.fsh)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/shaders/warhol.fsh)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/multimedia/video/qmlvideofx/shaders/wobble.fsh)
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/network/securesocketclient/encrypted.png)
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
		/usr/lib/qt5/examples/network/torrent/icons/1downarrow.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/network/torrent/icons/1uparrow.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/network/torrent/icons/bottom.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/network/torrent/icons/edit_add.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/network/torrent/icons/edit_remove.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/network/torrent/icons/exit.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/network/torrent/icons/peertopeer.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/network/torrent/icons/player_pause.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/network/torrent/icons/player_play.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/network/torrent/icons/player_stop.png)
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
		/usr/lib/qt5/examples/nfc/corkboard/Mode.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/nfc/corkboard/NfcFlag.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/nfc/corkboard/cork.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/nfc/corkboard/corkboards.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/nfc/corkboard/note-yellow.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/nfc/corkboard/tack.png)
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/nfc/poster/poster.qml)
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
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_OPENGL_CUBE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/opengl/cube/cube)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/opengl/cube/cube.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/opengl/cube/fshader.glsl)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/opengl/cube/vshader.glsl)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_OPENGL_HELLOGL2
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/opengl/hellogl2/hellogl2)
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/opengl/qopenglwidget/qt.png)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_OPENGL_QOPENGLWINDOW
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/opengl/qopenglwindow/background.frag)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/opengl/qopenglwindow/qopenglwindow)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_OPENGL_TEXTURES
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/opengl/textures/images/side1.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/opengl/textures/images/side2.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/opengl/textures/images/side3.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/opengl/textures/images/side4.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/opengl/textures/images/side5.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/opengl/textures/images/side6.png)
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/positioning/geoflickr/flickr-90.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/positioning/geoflickr/flickr.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/positioning/geoflickr/flickrcommon/Progress.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/positioning/geoflickr/flickrcommon/RestModel.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/positioning/geoflickr/flickrcommon/ScrollBar.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/positioning/geoflickr/flickrcommon/Slider.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/positioning/geoflickr/flickrmobile/Button.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/positioning/geoflickr/flickrmobile/GeoTab.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/positioning/geoflickr/flickrmobile/GridDelegate.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/positioning/geoflickr/flickrmobile/ImageDetails.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/positioning/geoflickr/flickrmobile/ListDelegate.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/positioning/geoflickr/flickrmobile/TitleBar.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/positioning/geoflickr/flickrmobile/ToolBar.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/positioning/geoflickr/flickrmobile/images/gloss.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/positioning/geoflickr/flickrmobile/images/lineedit.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/positioning/geoflickr/flickrmobile/images/lineedit.sci)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/positioning/geoflickr/flickrmobile/images/moon.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/positioning/geoflickr/flickrmobile/images/quit.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/positioning/geoflickr/flickrmobile/images/star.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/positioning/geoflickr/flickrmobile/images/stripes.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/positioning/geoflickr/flickrmobile/images/sun.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/positioning/geoflickr/flickrmobile/images/titlebar.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/positioning/geoflickr/flickrmobile/images/titlebar.sci)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/positioning/geoflickr/flickrmobile/images/toolbutton.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/positioning/geoflickr/flickrmobile/images/toolbutton.sci)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/positioning/geoflickr/flickrmobile/nmealog.txt)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTLOCATION)),)
ifdef PTXCONF_QT5_EXAMPLES_POSITIONING_LOGFILEPOSITIONSOURCE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/positioning/logfilepositionsource/logfilepositionsource)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/positioning/logfilepositionsource/simplelog.txt)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTLOCATION)),)
ifdef PTXCONF_QT5_EXAMPLES_POSITIONING_SATELLITEINFO
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/positioning/satelliteinfo/satelliteinfo.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTLOCATION)),)
ifdef PTXCONF_QT5_EXAMPLES_POSITIONING_WEATHERINFO
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/positioning/weatherinfo/components/BigForecastIcon.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/positioning/weatherinfo/components/ForecastIcon.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/positioning/weatherinfo/components/WeatherIcon.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/positioning/weatherinfo/icons/README.txt)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/positioning/weatherinfo/icons/weather-few-clouds.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/positioning/weatherinfo/icons/weather-fog.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/positioning/weatherinfo/icons/weather-haze.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/positioning/weatherinfo/icons/weather-icy.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/positioning/weatherinfo/icons/weather-overcast.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/positioning/weatherinfo/icons/weather-showers.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/positioning/weatherinfo/icons/weather-sleet.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/positioning/weatherinfo/icons/weather-snow.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/positioning/weatherinfo/icons/weather-storm.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/positioning/weatherinfo/icons/weather-sunny-very-few-clouds.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/positioning/weatherinfo/icons/weather-sunny.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/positioning/weatherinfo/icons/weather-thundershower.png)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/positioning/weatherinfo/weatherinfo)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/positioning/weatherinfo/weatherinfo.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QML_NETWORKACCESSMANAGERFACTORY
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qml/networkaccessmanagerfactory/networkaccessmanagerfactory)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/qml/networkaccessmanagerfactory/view.qml)
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/qml/xmlhttprequest/data.xml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/qml/xmlhttprequest/get.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qml/xmlhttprequest/xmlhttprequest)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/qml/xmlhttprequest/xmlhttprequest.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QML_REFERENCEEXAMPLES_ADDING
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qml/referenceexamples/adding/adding)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/qml/referenceexamples/adding/example.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QML_REFERENCEEXAMPLES_ATTACHED
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qml/referenceexamples/attached/attached)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/qml/referenceexamples/attached/example.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QML_REFERENCEEXAMPLES_BINDING
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qml/referenceexamples/binding/binding)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/qml/referenceexamples/binding/example.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QML_REFERENCEEXAMPLES_COERCION
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qml/referenceexamples/coercion/coercion)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/qml/referenceexamples/coercion/example.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QML_REFERENCEEXAMPLES_DEFAULT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qml/referenceexamples/default/default)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/qml/referenceexamples/default/example.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QML_REFERENCEEXAMPLES_EXTENDED
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/qml/referenceexamples/extended/example.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qml/referenceexamples/extended/extended)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QML_REFERENCEEXAMPLES_GROUPED
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/qml/referenceexamples/grouped/example.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qml/referenceexamples/grouped/grouped)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QML_REFERENCEEXAMPLES_METHODS
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/qml/referenceexamples/methods/example.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qml/referenceexamples/methods/methods)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QML_REFERENCEEXAMPLES_PROPERTIES
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/qml/referenceexamples/properties/example.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qml/referenceexamples/properties/properties)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QML_REFERENCEEXAMPLES_SIGNAL
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/qml/referenceexamples/signal/example.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qml/referenceexamples/signal/signal)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QML_REFERENCEEXAMPLES_VALUESOURCE
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/qml/referenceexamples/valuesource/example.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/qml/referenceexamples/valuesource/valuesource)
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/animation/animation.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/animation/basics/animators.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/animation/basics/color-animation.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/animation/basics/images/face-smile.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/animation/basics/images/moon.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/animation/basics/images/shadow.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/animation/basics/images/star.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/animation/basics/images/sun.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/animation/basics/property-animation.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/animation/behaviors/SideRect.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/animation/behaviors/behavior-example.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/animation/behaviors/tvtennis.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/animation/behaviors/wigglytext.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/animation/easing/easing.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/animation/pathanimation/pathanimation.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/animation/pathinterpolator/pathinterpolator.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/animation/states/qt-logo.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/animation/states/states.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/animation/states/transitions.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_CANVAS
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/canvas/bezierCurve/bezierCurve.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/canvas/canvas)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/canvas/canvas.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/canvas/clip/clip.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/canvas/contents/qt-logo.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/canvas/quadraticCurveTo/quadraticCurveTo.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/canvas/roundedrect/roundedrect.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/canvas/smile/smile.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/canvas/squircle/squircle.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/canvas/squircle/squircle.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/canvas/tiger/tiger.js)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/canvas/tiger/tiger.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_DRAGANDDROP
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/draganddrop/draganddrop)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/draganddrop/draganddrop.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/draganddrop/tiles/DragTile.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/draganddrop/tiles/DropTile.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/draganddrop/tiles/tiles.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/draganddrop/views/gridview.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_EMBEDDEDINWIDGETS
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/embeddedinwidgets/TextBox.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/embeddedinwidgets/embeddedinwidgets)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/embeddedinwidgets/main.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_EXTERNALDRAGANDDROP
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/externaldraganddrop/DragAndDropTextItem.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/externaldraganddrop/externaldraganddrop)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/externaldraganddrop/externaldraganddrop.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_IMAGEELEMENTS
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/imageelements/animatedsprite.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/imageelements/borderimage.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/imageelements/content/BearSheet.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/imageelements/content/BorderImageSelector.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/imageelements/content/ImageCell.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/imageelements/content/MyBorderImage.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/imageelements/content/ShadowRectangle.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/imageelements/content/arrow.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/imageelements/content/bw.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/imageelements/content/colors-round.sci)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/imageelements/content/colors-stretch.sci)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/imageelements/content/colors.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/imageelements/content/qt-logo.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/imageelements/content/shadow.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/imageelements/content/speaker.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/imageelements/image.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/imageelements/imageelements)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/imageelements/imageelements.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/imageelements/shadows.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/imageelements/spritesequence.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_KEYINTERACTION
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/keyinteraction/focus/Core/ContextMenu.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/keyinteraction/focus/Core/GridMenu.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/keyinteraction/focus/Core/ListMenu.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/keyinteraction/focus/Core/ListViewDelegate.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/keyinteraction/focus/Core/TabMenu.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/keyinteraction/focus/Core/images/arrow.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/keyinteraction/focus/Core/images/qt-logo.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/keyinteraction/focus/focus.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/keyinteraction/keyinteraction)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/keyinteraction/keyinteraction.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_MOUSEAREA
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/mousearea/mousearea)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/mousearea/mousearea-wheel-example.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/mousearea/mousearea.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_POSITIONERS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/positioners/positioners)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/positioners/positioners-attachedproperties.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/positioners/positioners-transitions.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/positioners/positioners.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_QUICK_ACCESSIBILITY
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/quick-accessibility/accessibility.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/quick-accessibility/content/Button.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/quick-accessibility/content/Checkbox.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/quick-accessibility/content/Slider.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/quick-accessibility/quick-accessibility)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_RENDERCONTROL
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/rendercontrol/demo.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/rendercontrol/rendercontrol)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_RIGHTTOLEFT
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/righttoleft/layoutdirection/layoutdirection.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/righttoleft/layoutmirroring/layoutmirroring.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/righttoleft/righttoleft)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/righttoleft/righttoleft.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/righttoleft/textalignment/textalignment.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_SHADEREFFECTS
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/shadereffects/content/Slider.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/shadereffects/content/face-smile.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/shadereffects/content/qt-logo.png)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/shadereffects/shadereffects)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/shadereffects/shadereffects.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_TEXT
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/text/fonts/availableFonts.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/text/fonts/banner.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/text/fonts/content/fonts/tarzeau_ocr_a.ttf)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/text/fonts/fonts.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/text/fonts/hello.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/text/imgtag/TextWithImage.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/text/imgtag/images/face-sad.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/text/imgtag/images/face-smile-big.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/text/imgtag/images/face-smile.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/text/imgtag/images/heart200.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/text/imgtag/images/qtlogo.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/text/imgtag/images/starfish_2.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/text/imgtag/imgtag.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/text/styledtext-layout.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/text/text)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/text/text.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/text/textselection/pics/endHandle.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/text/textselection/pics/endHandle.sci)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/text/textselection/pics/startHandle.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/text/textselection/pics/startHandle.sci)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/text/textselection/textselection.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_THREADING
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/threading/threadedlistmodel/dataloader.js)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/threading/threadedlistmodel/doc/src/threadedlistmodel.qdoc)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/threading/threadedlistmodel/timedisplay.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/threading/threading)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/threading/threading.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/threading/workerscript/Spinner.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/threading/workerscript/workerscript.js)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/threading/workerscript/workerscript.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_TOUCHINTERACTION
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/touchinteraction/flickable/basic-flickable.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/touchinteraction/flickable/content/Panel.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/touchinteraction/flickable/content/cork.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/touchinteraction/flickable/content/note-yellow.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/touchinteraction/flickable/content/tack.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/touchinteraction/flickable/corkboards.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/touchinteraction/multipointtouch/bearwhack.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/touchinteraction/multipointtouch/content/AugmentedTouchPoint.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/touchinteraction/multipointtouch/content/Bear0.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/touchinteraction/multipointtouch/content/Bear1.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/touchinteraction/multipointtouch/content/Bear2.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/touchinteraction/multipointtouch/content/Bear3.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/touchinteraction/multipointtouch/content/BearB.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/touchinteraction/multipointtouch/content/BearWhackParticleSystem.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/touchinteraction/multipointtouch/content/ParticleFlame.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/touchinteraction/multipointtouch/content/blur-circle.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/touchinteraction/multipointtouch/content/blur-circle3.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/touchinteraction/multipointtouch/content/heart-blur.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/touchinteraction/multipointtouch/content/title.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/touchinteraction/multipointtouch/multiflame.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/touchinteraction/pincharea/flickresize.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/touchinteraction/pincharea/qt-logo.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/touchinteraction/touchinteraction)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/touchinteraction/touchinteraction.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_VIEWS
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/gridview/gridview-example.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/gridview/pics/AddressBook_48.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/gridview/pics/AudioPlayer_48.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/gridview/pics/Camera_48.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/gridview/pics/DateBook_48.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/gridview/pics/EMail_48.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/gridview/pics/TodoList_48.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/gridview/pics/VideoPlayer_48.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/listview/content/PetsModel.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/listview/content/PressAndHoldButton.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/listview/content/RecipesModel.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/listview/content/SmallText.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/listview/content/TextButton.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/listview/content/ToggleButton.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/listview/content/pics/arrow-down.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/listview/content/pics/arrow-up.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/listview/content/pics/fruit-salad.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/listview/content/pics/hamburger.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/listview/content/pics/lemonade.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/listview/content/pics/list-delete.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/listview/content/pics/minus-sign.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/listview/content/pics/moreDown.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/listview/content/pics/moreUp.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/listview/content/pics/pancakes.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/listview/content/pics/plus-sign.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/listview/content/pics/vegetable-soup.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/listview/displaymargin.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/listview/dynamiclist.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/listview/expandingdelegates.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/listview/highlight.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/listview/highlightranges.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/listview/sections.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/objectmodel/objectmodel.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/package/Delegate.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/package/view.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/parallax/content/Clock.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/parallax/content/ParallaxView.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/parallax/content/QuitButton.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/parallax/content/Smiley.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/parallax/content/background.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/parallax/content/center.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/parallax/content/clock-night.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/parallax/content/clock.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/parallax/content/hour.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/parallax/content/minute.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/parallax/content/pics/background.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/parallax/content/pics/face-smile.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/parallax/content/pics/home-page.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/parallax/content/pics/home-page.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/parallax/content/pics/shadow.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/parallax/content/pics/yast-joystick.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/parallax/content/pics/yast-wol.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/parallax/content/quit.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/parallax/content/second.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/parallax/parallax.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/pathview/pathview-example.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/pathview/pics/AddressBook_48.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/pathview/pics/AudioPlayer_48.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/pathview/pics/Camera_48.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/pathview/pics/DateBook_48.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/pathview/pics/EMail_48.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/pathview/pics/TodoList_48.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/pathview/pics/VideoPlayer_48.png)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/views/views)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/views.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/visualdatamodel/dragselection.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/views/visualdatamodel/slideshow.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_WINDOW
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/window/ScreenInfo.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/window/Splash.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/window/window)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/window/window.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_CUSTOMITEMS_DIALCONTROL
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/customitems/dialcontrol/content/Dial.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/customitems/dialcontrol/content/QuitButton.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/customitems/dialcontrol/content/background.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/customitems/dialcontrol/content/needle.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/customitems/dialcontrol/content/needle_shadow.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/customitems/dialcontrol/content/overlay.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/customitems/dialcontrol/content/quit.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/customitems/dialcontrol/dialcontrol.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/customitems/dialcontrol/doc/images/qml-dialcontrol-example.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/customitems/dialcontrol/doc/src/dialcontrol.qdoc)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_CUSTOMITEMS_MASKEDMOUSEAREA
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/customitems/maskedmousearea/images/cloud_1.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/customitems/maskedmousearea/images/cloud_2.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/customitems/maskedmousearea/images/moon.png)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/customitems/maskedmousearea/maskedmousearea)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/customitems/maskedmousearea/maskedmousearea.qml)
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
		/usr/lib/qt5/examples/quick/customitems/scrollbar/doc/images/qml-scrollbar-example.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/customitems/scrollbar/doc/src/scrollbar.qdoc)
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
		/usr/lib/qt5/examples/quick/customitems/tabwidget/doc/images/qml-tabwidget-example.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/customitems/tabwidget/doc/images/tab.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/customitems/tabwidget/doc/src/tabwidget.qdoc)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/customitems/tabwidget/main.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_DEMOS_CALQLATR
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/demos/calqlatr/calqlatr)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/calqlatr/calqlatr.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/calqlatr/content/Button.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/calqlatr/content/Display.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/calqlatr/content/NumberPad.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/calqlatr/content/calculator.js)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/calqlatr/content/images/paper-edge-left.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/calqlatr/content/images/paper-edge-right.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/calqlatr/content/images/paper-grip.png)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_DEMOS_CLOCKS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/demos/clocks/clocks)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/clocks/clocks.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/clocks/content/Clock.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/clocks/content/arrow.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/clocks/content/background.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/clocks/content/center.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/clocks/content/clock-night.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/clocks/content/clock.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/clocks/content/hour.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/clocks/content/minute.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/clocks/content/quit.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/clocks/content/second.png)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_DEMOS_MAROON
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/BuildButton.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/GameCanvas.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/GameOverScreen.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/InfoBar.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/NewGameScreen.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/SoundEffect.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/audio/bomb-action.wav)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/audio/catch-action.wav)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/audio/catch.wav)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/audio/currency.wav)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/audio/factory-action.wav)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/audio/melee-action.wav)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/audio/projectile-action.wav)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/audio/shooter-action.wav)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/gfx/background.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/gfx/bomb-action.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/gfx/bomb-idle.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/gfx/bomb.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/gfx/button-help.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/gfx/button-play.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/gfx/catch-action.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/gfx/catch.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/gfx/cloud.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/gfx/currency.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/gfx/dialog-bomb.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/gfx/dialog-factory.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/gfx/dialog-melee.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/gfx/dialog-pointer.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/gfx/dialog-shooter.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/gfx/dialog.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/gfx/factory-action.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/gfx/factory-idle.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/gfx/factory.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/gfx/grid.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/gfx/help.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/gfx/lifes.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/gfx/logo-bubble.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/gfx/logo-fish.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/gfx/logo.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/gfx/melee-action.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/gfx/melee-idle.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/gfx/melee.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/gfx/mob-idle.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/gfx/mob.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/gfx/points.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/gfx/projectile-action.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/gfx/projectile.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/gfx/scores.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/gfx/shooter-action.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/gfx/shooter-idle.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/gfx/shooter.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/gfx/sunlight.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/gfx/text-1.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/gfx/text-2.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/gfx/text-3.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/gfx/text-blank.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/gfx/text-gameover.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/gfx/text-go.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/gfx/wave.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/logic.js)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/mobs/MobBase.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/towers/Bomb.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/towers/Factory.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/towers/Melee.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/towers/Ranged.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/content/towers/TowerBase.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/maroon)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/maroon/maroon.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_DEMOS_PHOTOSURFACE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/demos/photosurface/photosurface)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/photosurface/photosurface.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/photosurface/resources/folder.png)
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/photoviewer/PhotoViewerCore/AlbumDelegate.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/photoviewer/PhotoViewerCore/BusyIndicator.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/photoviewer/PhotoViewerCore/Button.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/photoviewer/PhotoViewerCore/EditableButton.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/photoviewer/PhotoViewerCore/PhotoDelegate.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/photoviewer/PhotoViewerCore/ProgressBar.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/photoviewer/PhotoViewerCore/RssModel.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/photoviewer/PhotoViewerCore/Tag.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/photoviewer/PhotoViewerCore/images/box-shadow.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/photoviewer/PhotoViewerCore/images/busy.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/photoviewer/PhotoViewerCore/images/cardboard.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/photoviewer/PhotoViewerCore/script/script.js)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/photoviewer/deployment.pri)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/photoviewer/doc/images/qtquick-demo-photoviewer-small.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/photoviewer/doc/src/photoviewer.qdoc)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/photoviewer/i18n/qml_de.qm)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/photoviewer/i18n/qml_de.ts)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/photoviewer/i18n/qml_fr.qm)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/photoviewer/i18n/qml_fr.ts)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/photoviewer/main.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_DEMOS_RSSNEWS
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/rssnews/content/BusyIndicator.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/rssnews/content/CategoryDelegate.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/rssnews/content/NewsDelegate.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/rssnews/content/RssFeeds.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/rssnews/content/ScrollBar.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/rssnews/content/images/Asia.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/rssnews/content/images/Business.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/rssnews/content/images/Entertainment.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/rssnews/content/images/Europe.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/rssnews/content/images/Health.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/rssnews/content/images/Politics.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/rssnews/content/images/Science.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/rssnews/content/images/Sports.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/rssnews/content/images/Technology.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/rssnews/content/images/TopStories.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/rssnews/content/images/USNational.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/rssnews/content/images/World.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/rssnews/content/images/btn_close.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/rssnews/content/images/busy.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/rssnews/content/images/scrollbar.png)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/demos/rssnews/rssnews)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/rssnews/rssnews.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_DEMOS_SAMEGAME
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/+blackberry/Settings.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/BBSettings.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/Block.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/BlockEmitter.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/Button.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/GameArea.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/LogoAnimation.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/MenuEmitter.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/PaintEmitter.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/PrimaryPack.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/PuzzleBlock.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/SamegameText.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/Settings.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/SimpleBlock.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/SmokeText.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/gfx/background-puzzle.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/gfx/background.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/gfx/bar.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/gfx/blue-puzzle.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/gfx/blue.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/gfx/bubble-highscore.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/gfx/bubble-puzzle.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/gfx/but-game-1.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/gfx/but-game-2.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/gfx/but-game-3.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/gfx/but-game-4.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/gfx/but-game-new.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/gfx/but-menu.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/gfx/but-puzzle-next.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/gfx/but-quit.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/gfx/green-puzzle.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/gfx/green.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/gfx/icon-fail.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/gfx/icon-ok.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/gfx/icon-time.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/gfx/logo-a.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/gfx/logo-e.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/gfx/logo-g.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/gfx/logo-m.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/gfx/logo-s.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/gfx/logo.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/gfx/particle-brick.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/gfx/particle-paint.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/gfx/particle-smoke.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/gfx/red-puzzle.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/gfx/red.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/gfx/text-highscore-new.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/gfx/text-highscore.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/gfx/text-no-winner.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/gfx/text-p1-go.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/gfx/text-p1-won.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/gfx/text-p1.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/gfx/text-p2-go.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/gfx/text-p2-won.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/gfx/text-p2.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/gfx/yellow-puzzle.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/gfx/yellow.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/levels/TemplateBase.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/levels/level0.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/levels/level1.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/levels/level2.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/levels/level3.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/levels/level4.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/levels/level5.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/levels/level6.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/levels/level7.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/levels/level8.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/levels/level9.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/qmldir)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/content/samegame.js)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/samegame)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/samegame/samegame.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_DEMOS_STOCQT
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/stocqt/content/Button.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/stocqt/content/CheckBox.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/stocqt/content/StockChart.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/stocqt/content/StockInfo.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/stocqt/content/StockListModel.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/stocqt/content/StockListView.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/stocqt/content/StockModel.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/stocqt/content/StockSettingsPanel.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/stocqt/content/StockView.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/stocqt/content/images/icon-left-arrow.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/stocqt/content/images/wheel-touch.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/stocqt/content/images/wheel.png)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/demos/stocqt/stocqt)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/stocqt/stocqt.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_DEMOS_TWEETSEARCH
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/tweetsearch/content/FlipBar.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/tweetsearch/content/LineInput.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/tweetsearch/content/ListFooter.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/tweetsearch/content/ListHeader.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/tweetsearch/content/SearchDelegate.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/tweetsearch/content/TweetDelegate.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/tweetsearch/content/TweetsModel.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/tweetsearch/content/resources/anonymous.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/tweetsearch/content/resources/bird-anim-sprites.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/tweetsearch/content/resources/icon-clear.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/tweetsearch/content/resources/icon-loading.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/tweetsearch/content/resources/icon-refresh.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/tweetsearch/content/resources/icon-search.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/tweetsearch/content/tweetsearch.js)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/demos/tweetsearch/tweetsearch)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/demos/tweetsearch/tweetsearch.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_LOCALSTORAGE_LOCALSTORAGE
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/localstorage/localstorage/hello.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/localstorage/localstorage/localstorage)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/localstorage/localstorage/localstorage.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_MODELS_ABSTRACTITEMMODEL
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/models/abstractitemmodel/abstractitemmodel)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/models/abstractitemmodel/view.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_MODELS_OBJECTLISTMODEL
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/models/objectlistmodel/objectlistmodel)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/models/objectlistmodel/view.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_MODELS_STRINGLISTMODEL
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/models/stringlistmodel/stringlistmodel)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/models/stringlistmodel/view.qml)
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/particles/affectors/affectors.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/particles/affectors/content/GreyButton.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/particles/affectors/content/age.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/particles/affectors/content/attractor.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/particles/affectors/content/customaffector.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/particles/affectors/content/friction.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/particles/affectors/content/gravity.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/particles/affectors/content/groupgoal.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/particles/affectors/content/move.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/particles/affectors/content/spritegoal.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/particles/affectors/content/turbulence.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/particles/affectors/content/wander.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_PARTICLES_CUSTOMPARTICLE
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/particles/customparticle/content/blurparticles.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/particles/customparticle/content/fragmentshader.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/particles/customparticle/content/imagecolors.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/particles/customparticle/customparticle)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/particles/customparticle/customparticle.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_PARTICLES_EMITTERS
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/particles/emitters/content/burstandpulse.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/particles/emitters/content/customemitter.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/particles/emitters/content/emitmask.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/particles/emitters/content/maximumemitted.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/particles/emitters/content/shapeanddirection.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/particles/emitters/content/trailemitter.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/particles/emitters/content/velocityfrommotion.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/particles/emitters/emitters)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/particles/emitters/emitters.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_PARTICLES_IMAGEPARTICLE
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/particles/imageparticle/content/allatonce.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/particles/imageparticle/content/colored.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/particles/imageparticle/content/colortable.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/particles/imageparticle/content/deformation.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/particles/imageparticle/content/rotation.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/particles/imageparticle/content/sharing.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/particles/imageparticle/content/sprites.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/particles/imageparticle/imageparticle)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/particles/imageparticle/imageparticle.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_PARTICLES_SYSTEM
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/particles/system/content/dynamiccomparison.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/particles/system/content/dynamicemitters.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/particles/system/content/multiplepainters.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/particles/system/content/startstop.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/particles/system/content/timedgroupchanges.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/particles/system/system)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/particles/system/system.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_QUICKWIDGETS_QQUICKVIEWCOMPARISON
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/quickwidgets/qquickviewcomparison/test.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_QUICKWIDGETS_QUICKWIDGET
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/quickwidgets/quickwidget/rotatingsquare.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_SCENEGRAPH_CUSTOMGEOMETRY
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/scenegraph/customgeometry/customgeometry)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/scenegraph/customgeometry/main.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_SCENEGRAPH_OPENGLUNDERQML
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/scenegraph/openglunderqml/main.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/scenegraph/openglunderqml/openglunderqml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_SCENEGRAPH_SGENGINE
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/scenegraph/sgengine/face-smile.png)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/scenegraph/sgengine/sgengine)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_SCENEGRAPH_SIMPLEMATERIAL
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/scenegraph/simplematerial/main.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/scenegraph/simplematerial/simplematerial)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_SCENEGRAPH_TEXTUREINSGNODE
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/scenegraph/textureinsgnode/main.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/scenegraph/textureinsgnode/textureinsgnode)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_SCENEGRAPH_TEXTUREINTHREAD
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/scenegraph/textureinthread/error.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/scenegraph/textureinthread/main.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/scenegraph/textureinthread/textureinthread)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_SCENEGRAPH_THREADEDANIMATION
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/scenegraph/threadedanimation/main.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/scenegraph/threadedanimation/spinner.png)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/scenegraph/threadedanimation/threadedanimation)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTDECLARATIVE)),)
ifdef PTXCONF_QT5_EXAMPLES_QUICK_SCENEGRAPH_TWOTEXTUREPROVIDERS
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/quick/scenegraph/twotextureproviders/main.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/quick/scenegraph/twotextureproviders/twotextureproviders)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSCRIPT)),)
ifdef PTXCONF_QT5_EXAMPLES_SCRIPT_CALCULATOR
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/script/calculator/calculator)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/script/calculator/calculator.js)
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/script/customclass/bytearrayclass.pri)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/script/customclass/customclass)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSCRIPT)),)
ifdef PTXCONF_QT5_EXAMPLES_SCRIPT_DEFAULTPROTOTYPES
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/script/defaultprototypes/code.js)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/script/defaultprototypes/defaultprototypes)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSCRIPT)),)
ifdef PTXCONF_QT5_EXAMPLES_SCRIPT_HELLOSCRIPT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/script/helloscript/helloscript)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/script/helloscript/helloscript.js)
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/script/qsdbg/qsdbg.pri)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSCRIPT)),)
ifdef PTXCONF_QT5_EXAMPLES_SCRIPT_QSTETRIX
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/script/qstetrix/qstetrix)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/script/qstetrix/tetrixboard.js)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/script/qstetrix/tetrixpiece.js)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/script/qstetrix/tetrixwindow.js)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_SQL_BOOKS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/sql/books/books)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/sql/books/images/star.png)
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/sql/drilldown/images/qt-creator.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/sql/drilldown/images/qt-logo.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/sql/drilldown/images/qt-project.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/sql/drilldown/images/qt-quick.png)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_SQL_MASTERDETAIL
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/sql/masterdetail/albumdetails.xml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/sql/masterdetail/images/icon.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/sql/masterdetail/images/image.png)
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embeddedsvgviewer/files/default.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embeddedsvgviewer/files/v-slider-handle.svg)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSVG)),)
ifdef PTXCONF_QT5_EXAMPLES_SVG_SVGGENERATOR
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/svggenerator/resources/shapes.dat)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/svg/svggenerator/svggenerator)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSVG)),)
ifdef PTXCONF_QT5_EXAMPLES_SVG_SVGVIEWER
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/svgviewer/files/bubbles.svg)
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/draganddrop/delayedencoding/images/drag.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/draganddrop/delayedencoding/images/example.svg)
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
		/usr/lib/qt5/examples/svg/embedded/desktopservices/resources/browser.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/desktopservices/resources/heart.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/desktopservices/resources/message.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/desktopservices/resources/music.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/desktopservices/resources/photo.png)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSVG)),)
ifdef PTXCONF_QT5_EXAMPLES_SVG_EMBEDDED_FLUIDLAUNCHER
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/fluidlauncher/config.xml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/svg/embedded/fluidlauncher/fluidlauncher)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/fluidlauncher/screenshots/anomaly_s60.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/fluidlauncher/screenshots/concentriccircles.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/fluidlauncher/screenshots/context2d_s60.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/fluidlauncher/screenshots/deform.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/fluidlauncher/screenshots/desktopservices_s60.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/fluidlauncher/screenshots/digiflip.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/fluidlauncher/screenshots/elasticnodes.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/fluidlauncher/screenshots/embeddedsvgviewer.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/fluidlauncher/screenshots/embeddedsvgviewer_s60.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/fluidlauncher/screenshots/flickable.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/fluidlauncher/screenshots/flightinfo_s60.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/fluidlauncher/screenshots/fridgemagnets_s60.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/fluidlauncher/screenshots/ftp_s60.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/fluidlauncher/screenshots/lightmaps.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/fluidlauncher/screenshots/mediaplayer.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/fluidlauncher/screenshots/pathstroke.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/fluidlauncher/screenshots/qmlcalculator.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/fluidlauncher/screenshots/qmlclocks.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/fluidlauncher/screenshots/qmldialcontrol.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/fluidlauncher/screenshots/qmleasing.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/fluidlauncher/screenshots/qmlflickr.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/fluidlauncher/screenshots/qmlphotoviewer.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/fluidlauncher/screenshots/qmltwitter.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/fluidlauncher/screenshots/raycasting.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/fluidlauncher/screenshots/saxbookmarks_s60.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/fluidlauncher/screenshots/softkeys_s60.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/fluidlauncher/screenshots/spectrum.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/fluidlauncher/screenshots/styledemo.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/fluidlauncher/screenshots/styledemo_s60.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/fluidlauncher/screenshots/weatherinfo.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/fluidlauncher/screenshots/wiggly.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/fluidlauncher/screenshots/wiggly_s60.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/fluidlauncher/slides/demo_1.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/fluidlauncher/slides/demo_2.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/fluidlauncher/slides/demo_3.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/fluidlauncher/slides/demo_4.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/fluidlauncher/slides/demo_5.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/fluidlauncher/slides/demo_6.png)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSVG)),)
ifdef PTXCONF_QT5_EXAMPLES_SVG_EMBEDDED_WEATHERINFO
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/weatherinfo/icons/README.txt)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/weatherinfo/icons/weather-few-clouds.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/weatherinfo/icons/weather-fog.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/weatherinfo/icons/weather-haze.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/weatherinfo/icons/weather-icy.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/weatherinfo/icons/weather-overcast.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/weatherinfo/icons/weather-showers.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/weatherinfo/icons/weather-sleet.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/weatherinfo/icons/weather-snow.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/weatherinfo/icons/weather-storm.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/weatherinfo/icons/weather-sunny-very-few-clouds.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/weatherinfo/icons/weather-sunny.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/embedded/weatherinfo/icons/weather-thundershower.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/svg/embedded/weatherinfo/weatherinfo)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSVG)),)
ifdef PTXCONF_QT5_EXAMPLES_SVG_NETWORK_BEARERCLOUD
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/svg/network/bearercloud/bearercloud)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/network/bearercloud/bluetooth.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/network/bearercloud/cell.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/network/bearercloud/gprs.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/network/bearercloud/lan.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/network/bearercloud/umts.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/network/bearercloud/unknown.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/network/bearercloud/wlan.svg)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSVG)),)
ifdef PTXCONF_QT5_EXAMPLES_SVG_OPENGL_FRAMEBUFFEROBJECT
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/opengl/framebufferobject/bubbles.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/opengl/framebufferobject/designer.png)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/svg/opengl/framebufferobject/framebufferobject)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTSVG)),)
ifdef PTXCONF_QT5_EXAMPLES_SVG_RICHTEXT_TEXTOBJECT
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/svg/richtext/textobject/files/heart.svg)
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/touch/pinchzoom/images/cheese.jpg)
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/uitools/textfinder/forms/input.txt)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/uitools/textfinder/textfinder)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTWEBCHANNEL)),)
ifdef PTXCONF_QT5_EXAMPLES_WEBCHANNEL_CHATSERVER
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTWEBCHANNEL)),)
ifdef PTXCONF_QT5_EXAMPLES_WEBCHANNEL_STANDALONE
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTWEBENGINE)),)
ifdef PTXCONF_QT5_EXAMPLES_WEBENGINE_QUICKNANOBROWSER
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webengine/quicknanobrowser/icons/go-next.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webengine/quicknanobrowser/icons/go-previous.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webengine/quicknanobrowser/icons/process-stop.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webengine/quicknanobrowser/icons/view-refresh.png)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/webengine/quicknanobrowser/quicknanobrowser)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webengine/quicknanobrowser/quickwindow.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTWEBENGINE)),)
ifdef PTXCONF_QT5_EXAMPLES_WEBENGINEWIDGETS_BROWSER
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webenginewidgets/browser/Info_mac.plist)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/webenginewidgets/browser/browser)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webenginewidgets/browser/browser.icns)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webenginewidgets/browser/browser.ico)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webenginewidgets/browser/data/addtab.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webenginewidgets/browser/data/browser.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webenginewidgets/browser/data/closetab.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webenginewidgets/browser/data/defaultbookmarks.xbel)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webenginewidgets/browser/data/defaulticon.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webenginewidgets/browser/data/history.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webenginewidgets/browser/data/loading.gif)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webenginewidgets/browser/htmls/notfound.html)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTWEBENGINE)),)
ifdef PTXCONF_QT5_EXAMPLES_WEBENGINEWIDGETS_FANCYBROWSER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/webenginewidgets/fancybrowser/fancybrowser)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webenginewidgets/fancybrowser/jquery.min.js)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTWEBKIT_EXAMPLES)),)
ifdef PTXCONF_QT5_EXAMPLES_WEBKITQML
	@$(call install_tree, qt5-examples, 0, 0, -, \
		/usr/lib/qt5/examples/webkitqml/shared)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTWEBKIT_EXAMPLES)),)
ifdef PTXCONF_QT5_EXAMPLES_WEBKITQML_FLICKRVIEW
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/webkitqml/flickrview/flickrview)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webkitqml/flickrview/flickrview.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webkitqml/flickrview/images/flickr.png)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTWEBKIT_EXAMPLES)),)
ifdef PTXCONF_QT5_EXAMPLES_WEBKITQML_YOUTUBEVIEW
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webkitqml/youtubeview/content/YouTubeDialog.qml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webkitqml/youtubeview/content/player.html)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/webkitqml/youtubeview/youtubeview)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webkitqml/youtubeview/youtubeview.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTWEBKIT_EXAMPLES)),)
ifdef PTXCONF_QT5_EXAMPLES_WEBKITWIDGETS_BROWSER
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webkitwidgets/browser/Info_mac.plist)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/webkitwidgets/browser/browser)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webkitwidgets/browser/browser.icns)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webkitwidgets/browser/browser.ico)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webkitwidgets/browser/data/addtab.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webkitwidgets/browser/data/browser.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webkitwidgets/browser/data/closetab.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webkitwidgets/browser/data/defaultbookmarks.xbel)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webkitwidgets/browser/data/defaulticon.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webkitwidgets/browser/data/history.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webkitwidgets/browser/data/loading.gif)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webkitwidgets/browser/htmls/notfound.html)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTWEBKIT_EXAMPLES)),)
ifdef PTXCONF_QT5_EXAMPLES_WEBKITWIDGETS_DOMTRAVERSAL
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/webkitwidgets/domtraversal/domtraversal)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTWEBKIT_EXAMPLES)),)
ifdef PTXCONF_QT5_EXAMPLES_WEBKITWIDGETS_FANCYBROWSER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/webkitwidgets/fancybrowser/fancybrowser)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webkitwidgets/fancybrowser/jquery.min.js)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTWEBKIT_EXAMPLES)),)
ifdef PTXCONF_QT5_EXAMPLES_WEBKITWIDGETS_FORMEXTRACTOR
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webkitwidgets/formextractor/form.html)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/webkitwidgets/formextractor/formextractor)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTWEBKIT_EXAMPLES)),)
ifdef PTXCONF_QT5_EXAMPLES_WEBKITWIDGETS_FRAMECAPTURE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/webkitwidgets/framecapture/framecapture)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTWEBKIT_EXAMPLES)),)
ifdef PTXCONF_QT5_EXAMPLES_WEBKITWIDGETS_IMAGEANALYZER
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webkitwidgets/imageanalyzer/README)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webkitwidgets/imageanalyzer/resources/images/README)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webkitwidgets/imageanalyzer/resources/images/bellaCoola.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webkitwidgets/imageanalyzer/resources/images/flower.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webkitwidgets/imageanalyzer/resources/images/mtRainier.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webkitwidgets/imageanalyzer/resources/images/seaShell.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webkitwidgets/imageanalyzer/resources/images/trees.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webkitwidgets/imageanalyzer/resources/index.html)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTWEBKIT_EXAMPLES)),)
ifdef PTXCONF_QT5_EXAMPLES_WEBKITWIDGETS_PREVIEWER
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/webkitwidgets/previewer/previewer)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTWEBKIT_EXAMPLES)),)
ifdef PTXCONF_QT5_EXAMPLES_WEBKITWIDGETS_SIMPLESELECTOR
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/webkitwidgets/simpleselector/simpleselector)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTWEBKIT_EXAMPLES)),)
ifdef PTXCONF_QT5_EXAMPLES_WEBKITWIDGETS_EMBEDDED_ANOMALY
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/webkitwidgets/embedded/anomaly/anomaly)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webkitwidgets/embedded/anomaly/src/images/button-close.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webkitwidgets/embedded/anomaly/src/images/edit-find.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webkitwidgets/embedded/anomaly/src/images/go-next.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webkitwidgets/embedded/anomaly/src/images/go-previous.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webkitwidgets/embedded/anomaly/src/images/list-add.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webkitwidgets/embedded/anomaly/src/images/list-remove.png)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTWEBKIT_EXAMPLES)),)
ifdef PTXCONF_QT5_EXAMPLES_WEBKITWIDGETS_SCROLLER_PLOT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/webkitwidgets/scroller/plot/plot)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTWEBKIT_EXAMPLES)),)
ifdef PTXCONF_QT5_EXAMPLES_WEBKITWIDGETS_SCROLLER_WHEEL
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/webkitwidgets/scroller/wheel/wheel)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTWEBKIT_EXAMPLES)),)
ifdef PTXCONF_QT5_EXAMPLES_WEBKITWIDGETS_XMLPATTERNS_QOBJECTXMLMODEL
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/webkitwidgets/xmlpatterns/qobjectxmlmodel/qobjectxmlmodel)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webkitwidgets/xmlpatterns/qobjectxmlmodel/queries/statisticsInHTML.xq)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/webkitwidgets/xmlpatterns/qobjectxmlmodel/queries/wholeTree.xq)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTWEBSOCKETS)),)
ifdef PTXCONF_QT5_EXAMPLES_WEBSOCKETS_ECHOCLIENT
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTWEBSOCKETS)),)
ifdef PTXCONF_QT5_EXAMPLES_WEBSOCKETS_ECHOSERVER
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTWEBSOCKETS)),)
ifdef PTXCONF_QT5_EXAMPLES_WEBSOCKETS_QMLWEBSOCKETCLIENT
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/websockets/qmlwebsocketclient/qml/qmlwebsocketclient/main.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTWEBSOCKETS)),)
ifdef PTXCONF_QT5_EXAMPLES_WEBSOCKETS_QMLWEBSOCKETSERVER
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/websockets/qmlwebsocketserver/qml/qmlwebsocketserver/main.qml)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTWEBSOCKETS)),)
ifdef PTXCONF_QT5_EXAMPLES_WEBSOCKETS_CHATSERVER
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTWEBSOCKETS)),)
ifdef PTXCONF_QT5_EXAMPLES_WEBSOCKETS_SSLECHOCLIENT
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTWEBSOCKETS)),)
ifdef PTXCONF_QT5_EXAMPLES_WEBSOCKETS_SSLECHOSERVER
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/websockets/sslechoserver/localhost.cert)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/websockets/sslechoserver/localhost.key)
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/animatedtiles/images/Time-For-Lunch-2.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/animatedtiles/images/centered.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/animatedtiles/images/ellipse.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/animatedtiles/images/figure8.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/animatedtiles/images/kinetic.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/animatedtiles/images/random.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/animatedtiles/images/tile.png)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_ANIMATION_APPCHOOSER
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/appchooser/accessories-dictionary.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/appchooser/akregator.png)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/animation/appchooser/appchooser)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/appchooser/digikam.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/appchooser/k3b.png)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_ANIMATION_EASING
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/animation/easing/easing)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/easing/images/qt-logo.png)
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/states/accessories-dictionary.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/states/akregator.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/states/digikam.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/states/help-browser.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/states/k3b.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/states/kchart.png)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/animation/states/states)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_ANIMATION_STICKMAN
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/stickman/animations/chilling.bin)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/stickman/animations/dancing.bin)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/stickman/animations/dead.bin)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/stickman/animations/jumping.bin)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/animation/stickman/stickman)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_ANIMATION_SUB_ATTAQ
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/data.xml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/big/background.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/big/boat.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/big/bomb.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/big/explosion/boat/step1.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/big/explosion/boat/step2.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/big/explosion/boat/step3.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/big/explosion/boat/step4.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/big/explosion/submarine/step1.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/big/explosion/submarine/step2.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/big/explosion/submarine/step3.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/big/explosion/submarine/step4.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/big/submarine.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/big/surface.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/big/torpedo.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/scalable/background-n810.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/scalable/background.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/scalable/boat.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/scalable/bomb.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/scalable/sand.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/scalable/see.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/scalable/sky.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/scalable/sub-attaq.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/scalable/submarine.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/scalable/surface.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/scalable/torpedo.svg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/small/background.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/small/boat.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/small/bomb.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/small/submarine.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/small/surface.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/small/torpedo.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/welcome/logo-a.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/welcome/logo-a2.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/welcome/logo-b.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/welcome/logo-dash.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/welcome/logo-excl.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/welcome/logo-q.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/welcome/logo-s.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/welcome/logo-t.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/welcome/logo-t2.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/animation/sub-attaq/pics/welcome/logo-u.png)
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/desktop/systray/images/bad.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/desktop/systray/images/heart.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/desktop/systray/images/trash.png)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/desktop/systray/systray)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_DIALOGS_CLASSWIZARD
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/dialogs/classwizard/classwizard)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/dialogs/classwizard/images/background.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/dialogs/classwizard/images/banner.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/dialogs/classwizard/images/logo1.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/dialogs/classwizard/images/logo2.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/dialogs/classwizard/images/logo3.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/dialogs/classwizard/images/watermark1.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/dialogs/classwizard/images/watermark2.png)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_DIALOGS_CONFIGDIALOG
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/dialogs/configdialog/configdialog)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/dialogs/configdialog/images/config.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/dialogs/configdialog/images/query.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/dialogs/configdialog/images/update.png)
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/dialogs/licensewizard/images/logo.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/dialogs/licensewizard/images/watermark.png)
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/draganddrop/draggableicons/images/boat.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/draganddrop/draggableicons/images/car.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/draganddrop/draggableicons/images/house.png)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_DRAGANDDROP_DRAGGABLETEXT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/draganddrop/draggabletext/draggabletext)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/draganddrop/draggabletext/words.txt)
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/draganddrop/fridgemagnets/words.txt)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_DRAGANDDROP_PUZZLE
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/draganddrop/puzzle/example.jpg)
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/effects/blurpicker/images/accessories-calculator.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/effects/blurpicker/images/accessories-text-editor.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/effects/blurpicker/images/background.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/effects/blurpicker/images/help-browser.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/effects/blurpicker/images/internet-group-chat.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/effects/blurpicker/images/internet-mail.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/effects/blurpicker/images/internet-web-browser.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/effects/blurpicker/images/office-calendar.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/effects/blurpicker/images/system-users.png)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_EFFECTS_FADEMESSAGE
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/effects/fademessage/README)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/effects/fademessage/background.jpg)
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/basicgraphicslayouts/images/block.png)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_GRAPHICSVIEW_BOXES
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/boxes/3rdparty/fbm.c)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/boxes/basic.fsh)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/boxes/basic.vsh)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/boxes/boxes)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/boxes/cubemap_negx.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/boxes/cubemap_negy.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/boxes/cubemap_negz.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/boxes/cubemap_posx.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/boxes/cubemap_posy.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/boxes/cubemap_posz.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/boxes/dotted.fsh)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/boxes/fresnel.fsh)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/boxes/glass.fsh)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/boxes/granite.fsh)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/boxes/marble.fsh)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/boxes/parameters.par)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/boxes/qt-logo.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/boxes/qt-logo.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/boxes/reflection.fsh)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/boxes/refraction.fsh)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/boxes/smiley.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/boxes/square.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/boxes/wood.fsh)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_GRAPHICSVIEW_CHIP
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/chip/chip)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/chip/fileprint.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/chip/qt4logo.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/chip/rotateleft.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/chip/rotateright.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/chip/zoomin.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/chip/zoomout.png)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_GRAPHICSVIEW_COLLIDINGMICE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/collidingmice/collidingmice)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/collidingmice/images/cheese.jpg)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_GRAPHICSVIEW_DIAGRAMSCENE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/diagramscene/diagramscene)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/diagramscene/images/background1.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/diagramscene/images/background2.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/diagramscene/images/background3.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/diagramscene/images/background4.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/diagramscene/images/bold.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/diagramscene/images/bringtofront.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/diagramscene/images/delete.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/diagramscene/images/floodfill.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/diagramscene/images/italic.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/diagramscene/images/linecolor.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/diagramscene/images/linepointer.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/diagramscene/images/pointer.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/diagramscene/images/sendtoback.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/diagramscene/images/textpointer.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/diagramscene/images/underline.png)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_GRAPHICSVIEW_DRAGDROPROBOT
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/dragdroprobot/dragdroprobot)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/dragdroprobot/images/head.png)
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/embeddeddialogs/No-Ones-Laughing-3.jpg)
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/padnavigator/images/artsfftscope.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/padnavigator/images/blue_angle_swirl.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/padnavigator/images/kontact_contacts.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/padnavigator/images/kontact_journal.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/padnavigator/images/kontact_mail.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/padnavigator/images/kontact_notes.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/padnavigator/images/kopeteavailable.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/padnavigator/images/metacontact_online.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/padnavigator/images/minitools.png)
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/weatheranchorlayout/images/5days.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/weatheranchorlayout/images/details.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/weatheranchorlayout/images/place.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/weatheranchorlayout/images/tabbar.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/weatheranchorlayout/images/title.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/graphicsview/weatheranchorlayout/images/weather-few-clouds.png)
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/itemviews/chart/qtdata.cht)
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/itemviews/customsortfiltermodel/images/find.png)
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/itemviews/editabletreemodel/default.txt)
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/itemviews/frozencolumn/grades.txt)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_ITEMVIEWS_INTERVIEW
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/itemviews/interview/README)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/itemviews/interview/images/folder.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/itemviews/interview/images/interview.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/itemviews/interview/images/services.png)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/itemviews/interview/interview)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_ITEMVIEWS_PIXELATOR
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/itemviews/pixelator/images/qt.png)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/itemviews/pixelator/pixelator)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_ITEMVIEWS_PUZZLE
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/itemviews/puzzle/example.jpg)
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/itemviews/simpletreemodel/default.txt)
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/itemviews/spreadsheet/images/interview.png)
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/mainwindows/application/images/copy.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/mainwindows/application/images/cut.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/mainwindows/application/images/new.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/mainwindows/application/images/open.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/mainwindows/application/images/paste.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/mainwindows/application/images/save.png)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_MAINWINDOWS_DOCKWIDGETS
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/mainwindows/dockwidgets/dockwidgets)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/mainwindows/dockwidgets/images/new.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/mainwindows/dockwidgets/images/print.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/mainwindows/dockwidgets/images/save.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/mainwindows/dockwidgets/images/undo.png)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_MAINWINDOWS_MAINWINDOW
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/mainwindows/mainwindow/mainwindow)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/mainwindows/mainwindow/qt.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/mainwindows/mainwindow/titlebarCenter.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/mainwindows/mainwindow/titlebarLeft.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/mainwindows/mainwindow/titlebarRight.png)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_MAINWINDOWS_MDI
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/mainwindows/mdi/images/copy.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/mainwindows/mdi/images/cut.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/mainwindows/mdi/images/new.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/mainwindows/mdi/images/open.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/mainwindows/mdi/images/paste.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/mainwindows/mdi/images/save.png)
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
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_MAINWINDOWS_RECENTFILES
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/mainwindows/recentfiles/recentfiles)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_MAINWINDOWS_SDI
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/mainwindows/sdi/images/copy.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/mainwindows/sdi/images/cut.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/mainwindows/sdi/images/new.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/mainwindows/sdi/images/open.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/mainwindows/sdi/images/paste.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/mainwindows/sdi/images/save.png)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/mainwindows/sdi/sdi)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_PAINTING_AFFINE
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/painting/affine/affine)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/painting/affine/bg1.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/painting/affine/xform.html)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_PAINTING_BASICDRAWING
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/painting/basicdrawing/basicdrawing)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/painting/basicdrawing/images/brick.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/painting/basicdrawing/images/qt-logo.png)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_PAINTING_COMPOSITION
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/painting/composition/composition)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/painting/composition/composition.html)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/painting/composition/flower.jpg)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/painting/composition/flower_alpha.jpg)
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/painting/deform/pathdeform.html)
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/painting/gradients/gradients.html)
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/painting/imagecomposition/images/butterfly.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/painting/imagecomposition/images/checker.png)
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/painting/pathstroke/pathstroke.html)
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/richtext/textedit/example.html)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/richtext/textedit/images/logo32.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/richtext/textedit/images/mac/editcopy.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/richtext/textedit/images/mac/editcut.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/richtext/textedit/images/mac/editpaste.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/richtext/textedit/images/mac/editredo.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/richtext/textedit/images/mac/editundo.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/richtext/textedit/images/mac/exportpdf.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/richtext/textedit/images/mac/filenew.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/richtext/textedit/images/mac/fileopen.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/richtext/textedit/images/mac/fileprint.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/richtext/textedit/images/mac/filesave.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/richtext/textedit/images/mac/textbold.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/richtext/textedit/images/mac/textcenter.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/richtext/textedit/images/mac/textitalic.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/richtext/textedit/images/mac/textjustify.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/richtext/textedit/images/mac/textleft.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/richtext/textedit/images/mac/textright.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/richtext/textedit/images/mac/textunder.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/richtext/textedit/images/mac/zoomin.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/richtext/textedit/images/mac/zoomout.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/richtext/textedit/images/win/editcopy.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/richtext/textedit/images/win/editcut.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/richtext/textedit/images/win/editpaste.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/richtext/textedit/images/win/editredo.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/richtext/textedit/images/win/editundo.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/richtext/textedit/images/win/exportpdf.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/richtext/textedit/images/win/filenew.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/richtext/textedit/images/win/fileopen.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/richtext/textedit/images/win/fileprint.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/richtext/textedit/images/win/filesave.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/richtext/textedit/images/win/textbold.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/richtext/textedit/images/win/textcenter.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/richtext/textedit/images/win/textitalic.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/richtext/textedit/images/win/textjustify.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/richtext/textedit/images/win/textleft.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/richtext/textedit/images/win/textright.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/richtext/textedit/images/win/textunder.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/richtext/textedit/images/win/zoomin.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/richtext/textedit/images/win/zoomout.png)
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/styles/images/woodbackground.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/styles/images/woodbutton.png)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/widgets/styles/styles)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_WIDGETS_STYLESHEET
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/stylesheet/images/checkbox_checked.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/stylesheet/images/checkbox_checked_hover.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/stylesheet/images/checkbox_checked_pressed.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/stylesheet/images/checkbox_unchecked.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/stylesheet/images/checkbox_unchecked_hover.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/stylesheet/images/checkbox_unchecked_pressed.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/stylesheet/images/down_arrow.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/stylesheet/images/down_arrow_disabled.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/stylesheet/images/frame.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/stylesheet/images/pagefold.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/stylesheet/images/pushbutton.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/stylesheet/images/pushbutton_hover.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/stylesheet/images/pushbutton_pressed.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/stylesheet/images/radiobutton_checked.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/stylesheet/images/radiobutton_checked_hover.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/stylesheet/images/radiobutton_checked_pressed.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/stylesheet/images/radiobutton_unchecked.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/stylesheet/images/radiobutton_unchecked_hover.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/stylesheet/images/radiobutton_unchecked_pressed.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/stylesheet/images/sizegrip.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/stylesheet/images/spindown.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/stylesheet/images/spindown_hover.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/stylesheet/images/spindown_off.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/stylesheet/images/spindown_pressed.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/stylesheet/images/spinup.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/stylesheet/images/spinup_hover.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/stylesheet/images/spinup_off.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/stylesheet/images/spinup_pressed.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/stylesheet/images/up_arrow.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/stylesheet/images/up_arrow_disabled.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/stylesheet/qss/coffee.qss)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/stylesheet/qss/default.qss)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/stylesheet/qss/pagefold.qss)
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/tooltips/images/circle.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/tooltips/images/square.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/tooltips/images/triangle.png)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/widgets/widgets/tooltips/tooltips)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_WIDGETS_WIDGETS_VALIDATORS
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/validators/ledoff.png)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/widgets/widgets/validators/ledon.png)
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
		/usr/lib/qt5/examples/xml/dombookmarks/frank.xbel)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/xml/dombookmarks/jennifer.xbel)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_XML_HTMLINFO
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/xml/htmlinfo/apache_org.html)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/xml/htmlinfo/htmlinfo)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/xml/htmlinfo/nokia_com.html)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/xml/htmlinfo/simpleexample.html)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/xml/htmlinfo/trolltech_com.html)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/xml/htmlinfo/w3c_org.html)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/xml/htmlinfo/youtube_com.html)
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
		/usr/lib/qt5/examples/xml/saxbookmarks/frank.xbel)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/xml/saxbookmarks/jennifer.xbel)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/xml/saxbookmarks/saxbookmarks)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_XML_STREAMBOOKMARKS
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/xml/streambookmarks/frank.xbel)
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
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/xmlpatterns/filetree/queries/listCPPFiles.xq)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/xmlpatterns/filetree/queries/wholeTree.xq)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_XMLPATTERNS_RECIPES
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/xmlpatterns/recipes/files/allRecipes.xq)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/xmlpatterns/recipes/files/cookbook.xml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/xmlpatterns/recipes/files/liquidIngredientsInSoup.xq)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/xmlpatterns/recipes/files/mushroomSoup.xq)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/xmlpatterns/recipes/files/preparationLessThan30.xq)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/xmlpatterns/recipes/files/preparationTimes.xq)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/xmlpatterns/recipes/recipes)
endif
endif
ifneq ($(strip $(PTXCONF_QT5_MODULE_QTBASE)),)
ifdef PTXCONF_QT5_EXAMPLES_XMLPATTERNS_SCHEMA
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/xmlpatterns/schema/files/contact.xsd)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/xmlpatterns/schema/files/invalid_contact.xml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/xmlpatterns/schema/files/invalid_order.xml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/xmlpatterns/schema/files/invalid_recipe.xml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/xmlpatterns/schema/files/order.xsd)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/xmlpatterns/schema/files/recipe.xsd)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/xmlpatterns/schema/files/valid_contact.xml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/xmlpatterns/schema/files/valid_order.xml)
	@$(call install_copy, qt5-examples, 0, 0, 0644, -, \
		/usr/lib/qt5/examples/xmlpatterns/schema/files/valid_recipe.xml)
	@$(call install_copy, qt5-examples, 0, 0, 0755, -, \
		/usr/lib/qt5/examples/xmlpatterns/schema/schema)
endif
endif

	@$(call install_finish, qt5-examples)
	@$(call touch)

# vim: syntax=make
