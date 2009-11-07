# WARNING: this file is generated with qt4_mk_examples.sh
# do not edit

PTX_MAP_TO_PACKAGE_qt4-examples := QT4

ifdef PTXCONF_QT4_EXAMPLES
$(STATEDIR)/qt4.targetinstall.post: $(STATEDIR)/qt4-examples.targetinstall
endif

$(STATEDIR)/qt4-examples.targetinstall: $(STATEDIR)/qt4.targetinstall
	@$(call targetinfo, $@)
	@$(call install_init, qt4-examples)
	@$(call install_fixup,qt4-examples,PACKAGE,qt4-examples)
	@$(call install_fixup,qt4-examples,PRIORITY,optional)
	@$(call install_fixup,qt4-examples,VERSION,$(QT4_VERSION))
	@$(call install_fixup,qt4-examples,SECTION,base)
	@$(call install_fixup,qt4-examples,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,qt4-examples,DEPENDS,)
	@$(call install_fixup,qt4-examples,DESCRIPTION,missing)

ifdef PTXCONF_QT4_EXAMPLES_SIMPLETEXTVIEWER
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/assistant/simpletextviewer/simpletextviewer)
endif

ifdef PTXCONF_QT4_EXAMPLES_COMPLEXPING
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/dbus/complexpingpong/complexpong)
endif

ifdef PTXCONF_QT4_EXAMPLES_COMPLEXPONG
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/dbus/complexpingpong/complexpong)
endif

ifdef PTXCONF_QT4_EXAMPLES_DBUS_CHAT
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/dbus/chat/dbus-chat)
endif

ifdef PTXCONF_QT4_EXAMPLES_LISTNAMES
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/dbus/listnames/listnames)
endif

ifdef PTXCONF_QT4_EXAMPLES_PING
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/dbus/pingpong/pong)
endif

ifdef PTXCONF_QT4_EXAMPLES_PONG
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/dbus/pingpong/pong)
endif

ifdef PTXCONF_QT4_EXAMPLES_CAR
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/dbus/remotecontrolledcar/car/car)
endif

ifdef PTXCONF_QT4_EXAMPLES_CONTROLLER
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/dbus/remotecontrolledcar/controller/controller)
endif

ifdef PTXCONF_QT4_EXAMPLES_CALCULATORBUILDER
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/designer/calculatorbuilder/calculatorbuilder)
endif

ifdef PTXCONF_QT4_EXAMPLES_CALCULATORFORM
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/designer/calculatorform/calculatorform)
endif

ifdef PTXCONF_QT4_EXAMPLES_WORLDTIMECLOCKBUILDER
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/designer/worldtimeclockbuilder/worldtimeclockbuilder)
endif

ifdef PTXCONF_QT4_EXAMPLES_SCREENSHOT
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/desktop/screenshot/screenshot)
endif

ifdef PTXCONF_QT4_EXAMPLES_SYSTRAY
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/desktop/systray/systray)
endif

ifdef PTXCONF_QT4_EXAMPLES_CLASSWIZARD
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/dialogs/classwizard/classwizard)
endif

ifdef PTXCONF_QT4_EXAMPLES_CONFIGDIALOG
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/dialogs/configdialog/configdialog)
endif

ifdef PTXCONF_QT4_EXAMPLES_EXTENSION
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/dialogs/extension/extension)
endif

ifdef PTXCONF_QT4_EXAMPLES_FINDFILES
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/dialogs/findfiles/findfiles)
endif

ifdef PTXCONF_QT4_EXAMPLES_LICENSEWIZARD
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/dialogs/licensewizard/licensewizard)
endif

ifdef PTXCONF_QT4_EXAMPLES_STANDARDDIALOGS
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/dialogs/standarddialogs/standarddialogs)
endif

ifdef PTXCONF_QT4_EXAMPLES_TABDIALOG
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/dialogs/tabdialog/tabdialog)
endif

ifdef PTXCONF_QT4_EXAMPLES_TRIVIALWIZARD
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/dialogs/trivialwizard/trivialwizard)
endif

ifdef PTXCONF_QT4_EXAMPLES_DELAYEDENCODING
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/draganddrop/delayedencoding/delayedencoding)
endif

ifdef PTXCONF_QT4_EXAMPLES_DRAGGABLEICONS
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/draganddrop/draggableicons/draggableicons)
endif

ifdef PTXCONF_QT4_EXAMPLES_DRAGGABLETEXT
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/draganddrop/draggabletext/draggabletext)
endif

ifdef PTXCONF_QT4_EXAMPLES_DROPSITE
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/draganddrop/dropsite/dropsite)
endif

ifdef PTXCONF_QT4_EXAMPLES_FRIDGEMAGNETS
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/draganddrop/fridgemagnets/fridgemagnets)
endif

ifdef PTXCONF_QT4_EXAMPLES_PUZZLE
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/draganddrop/puzzle/puzzle)
endif

ifdef PTXCONF_QT4_EXAMPLES_BASICGRAPHICSLAYOUTS
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/graphicsview/basicgraphicslayouts/basicgraphicslayouts)
endif

ifdef PTXCONF_QT4_EXAMPLES_COLLIDINGMICE
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/graphicsview/collidingmice/collidingmice)
endif

ifdef PTXCONF_QT4_EXAMPLES_DIAGRAMSCENE
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/graphicsview/diagramscene/diagramscene)
endif

ifdef PTXCONF_QT4_EXAMPLES_DRAGDROPROBOT
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/graphicsview/dragdroprobot/dragdroprobot)
endif

ifdef PTXCONF_QT4_EXAMPLES_ELASTICNODES
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/graphicsview/elasticnodes/elasticnodes)
endif

ifdef PTXCONF_QT4_EXAMPLES_PADNAVIGATOR
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/graphicsview/padnavigator/padnavigator)
endif

ifdef PTXCONF_QT4_EXAMPLES_CONTEXTSENSITIVEHELP
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/help/contextsensitivehelp/contextsensitivehelp)
endif

ifdef PTXCONF_QT4_EXAMPLES_REMOTECONTROL
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/help/remotecontrol/remotecontrol)
endif

ifdef PTXCONF_QT4_EXAMPLES_SIMPLETEXTVIEWER
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/help/simpletextviewer/simpletextviewer)
endif

ifdef PTXCONF_QT4_EXAMPLES_LOCALFORTUNECLIENT
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/ipc/localfortuneclient/localfortuneclient)
endif

ifdef PTXCONF_QT4_EXAMPLES_LOCALFORTUNESERVER
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/ipc/localfortuneserver/localfortuneserver)
endif

ifdef PTXCONF_QT4_EXAMPLES_SHAREDMEMORY
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/ipc/sharedmemory/sharedmemory)
endif

ifdef PTXCONF_QT4_EXAMPLES_ADDRESSBOOK
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/itemviews/addressbook/addressbook)
endif

ifdef PTXCONF_QT4_EXAMPLES_BASICSORTFILTERMODEL
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/itemviews/basicsortfiltermodel/basicsortfiltermodel)
endif

ifdef PTXCONF_QT4_EXAMPLES_CHART
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/itemviews/chart/chart)
endif

ifdef PTXCONF_QT4_EXAMPLES_COLOREDITORFACTORY
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/itemviews/coloreditorfactory/coloreditorfactory)
endif

ifdef PTXCONF_QT4_EXAMPLES_COMBOWIDGETMAPPER
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/itemviews/combowidgetmapper/combowidgetmapper)
endif

ifdef PTXCONF_QT4_EXAMPLES_CUSTOMSORTFILTERMODEL
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/itemviews/customsortfiltermodel/customsortfiltermodel)
endif

ifdef PTXCONF_QT4_EXAMPLES_DIRVIEW
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/itemviews/dirview/dirview)
endif

ifdef PTXCONF_QT4_EXAMPLES_EDITABLETREEMODEL
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/itemviews/editabletreemodel/editabletreemodel)
endif

ifdef PTXCONF_QT4_EXAMPLES_FETCHMORE
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/itemviews/fetchmore/fetchmore)
endif

ifdef PTXCONF_QT4_EXAMPLES_FROZENCOLUMN
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/itemviews/frozencolumn/frozencolumn)
endif

ifdef PTXCONF_QT4_EXAMPLES_PIXELATOR
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/itemviews/pixelator/pixelator)
endif

ifdef PTXCONF_QT4_EXAMPLES_PUZZLE
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/itemviews/puzzle/puzzle)
endif

ifdef PTXCONF_QT4_EXAMPLES_SIMPLEDOMMODEL
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/itemviews/simpledommodel/simpledommodel)
endif

ifdef PTXCONF_QT4_EXAMPLES_SIMPLETREEMODEL
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/itemviews/simpletreemodel/simpletreemodel)
endif

ifdef PTXCONF_QT4_EXAMPLES_SIMPLEWIDGETMAPPER
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/itemviews/simplewidgetmapper/simplewidgetmapper)
endif

ifdef PTXCONF_QT4_EXAMPLES_SPINBOXDELEGATE
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/itemviews/spinboxdelegate/spinboxdelegate)
endif

ifdef PTXCONF_QT4_EXAMPLES_STARDELEGATE
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/itemviews/stardelegate/stardelegate)
endif

ifdef PTXCONF_QT4_EXAMPLES_BASICLAYOUTS
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/layouts/basiclayouts/basiclayouts)
endif

ifdef PTXCONF_QT4_EXAMPLES_BORDERLAYOUT
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/layouts/borderlayout/borderlayout)
endif

ifdef PTXCONF_QT4_EXAMPLES_DYNAMICLAYOUTS
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/layouts/dynamiclayouts/dynamiclayouts)
endif

ifdef PTXCONF_QT4_EXAMPLES_FLOWLAYOUT
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/layouts/flowlayout/flowlayout)
endif

ifdef PTXCONF_QT4_EXAMPLES_ARROWPAD
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/linguist/arrowpad/arrowpad)
endif

ifdef PTXCONF_QT4_EXAMPLES_HELLOTR
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/linguist/hellotr/hellotr)
endif

ifdef PTXCONF_QT4_EXAMPLES_TROLLPRINT
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/linguist/trollprint/trollprint)
endif

ifdef PTXCONF_QT4_EXAMPLES_APPLICATION
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/mainwindows/application/application)
endif

ifdef PTXCONF_QT4_EXAMPLES_DOCKWIDGETS
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/mainwindows/dockwidgets/dockwidgets)
endif

ifdef PTXCONF_QT4_EXAMPLES_MDI
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/mainwindows/mdi/mdi)
endif

ifdef PTXCONF_QT4_EXAMPLES_MENUS
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/mainwindows/menus/menus)
endif

ifdef PTXCONF_QT4_EXAMPLES_RECENTFILES
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/mainwindows/recentfiles/recentfiles)
endif

ifdef PTXCONF_QT4_EXAMPLES_SDI
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/mainwindows/sdi/sdi)
endif

ifdef PTXCONF_QT4_EXAMPLES_BLOCKINGFORTUNECLIENT
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/network/blockingfortuneclient/blockingfortuneclient)
endif

ifdef PTXCONF_QT4_EXAMPLES_BROADCASTRECEIVER
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/network/broadcastreceiver/broadcastreceiver)
endif

ifdef PTXCONF_QT4_EXAMPLES_BROADCASTSENDER
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/network/broadcastsender/broadcastsender)
endif

ifdef PTXCONF_QT4_EXAMPLES_DOWNLOAD
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/network/download/download)
endif

ifdef PTXCONF_QT4_EXAMPLES_DOWNLOADMANAGER
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/network/downloadmanager/downloadmanager)
endif

ifdef PTXCONF_QT4_EXAMPLES_FORTUNECLIENT
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/network/fortuneclient/fortuneclient)
endif

ifdef PTXCONF_QT4_EXAMPLES_FORTUNESERVER
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/network/fortuneserver/fortuneserver)
endif

ifdef PTXCONF_QT4_EXAMPLES_FTP
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/network/ftp/ftp)
endif

ifdef PTXCONF_QT4_EXAMPLES_GOOGLESUGGEST
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/network/googlesuggest/googlesuggest)
endif

ifdef PTXCONF_QT4_EXAMPLES_HTTP
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/network/http/http)
endif

ifdef PTXCONF_QT4_EXAMPLES_LOOPBACK
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/network/loopback/loopback)
endif

ifdef PTXCONF_QT4_EXAMPLES_NETWORK_CHAT
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/network/network-chat/network-chat)
endif

ifdef PTXCONF_QT4_EXAMPLES_THREADEDFORTUNESERVER
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/network/threadedfortuneserver/threadedfortuneserver)
endif

ifdef PTXCONF_QT4_EXAMPLES_TORRENT
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/network/torrent/torrent)
endif

ifdef PTXCONF_QT4_EXAMPLES_2DPAINTING
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/opengl/2dpainting/2dpainting)
endif

ifdef PTXCONF_QT4_EXAMPLES_FRAMEBUFFEROBJECT
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/opengl/framebufferobject/framebufferobject)
endif

ifdef PTXCONF_QT4_EXAMPLES_FRAMEBUFFEROBJECT2
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/opengl/framebufferobject2/framebufferobject2)
endif

ifdef PTXCONF_QT4_EXAMPLES_GRABBER
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/opengl/grabber/grabber)
endif

ifdef PTXCONF_QT4_EXAMPLES_HELLOGL
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/opengl/hellogl/hellogl)
endif

ifdef PTXCONF_QT4_EXAMPLES_OVERPAINTING
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/opengl/overpainting/overpainting)
endif

ifdef PTXCONF_QT4_EXAMPLES_PBUFFERS
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/opengl/pbuffers/pbuffers)
endif

ifdef PTXCONF_QT4_EXAMPLES_PBUFFERS2
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/opengl/pbuffers2/pbuffers2)
endif

ifdef PTXCONF_QT4_EXAMPLES_SAMPLEBUFFERS
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/opengl/samplebuffers/samplebuffers)
endif

ifdef PTXCONF_QT4_EXAMPLES_TEXTURES
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/opengl/textures/textures)
endif

ifdef PTXCONF_QT4_EXAMPLES_BASICDRAWING
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/painting/basicdrawing/basicdrawing)
endif

ifdef PTXCONF_QT4_EXAMPLES_CONCENTRICCIRCLES
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/painting/concentriccircles/concentriccircles)
endif

ifdef PTXCONF_QT4_EXAMPLES_FONTSAMPLER
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/painting/fontsampler/fontsampler)
endif

ifdef PTXCONF_QT4_EXAMPLES_IMAGECOMPOSITION
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/painting/imagecomposition/imagecomposition)
endif

ifdef PTXCONF_QT4_EXAMPLES_PAINTERPATHS
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/painting/painterpaths/painterpaths)
endif

ifdef PTXCONF_QT4_EXAMPLES_SVGGENERATOR
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/painting/svggenerator/svggenerator)
endif

ifdef PTXCONF_QT4_EXAMPLES_SVGVIEWER
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/painting/svgviewer/svgviewer)
endif

ifdef PTXCONF_QT4_EXAMPLES_TRANSFORMATIONS
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/painting/transformations/transformations)
endif

ifdef PTXCONF_QT4_EXAMPLES_CAPABILITIES
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/phonon/capabilities/capabilities)
endif

ifdef PTXCONF_QT4_EXAMPLES_MUSICPLAYER
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/phonon/musicplayer/musicplayer)
endif

ifdef PTXCONF_QT4_EXAMPLES_IMAGESCALING
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/qtconcurrent/imagescaling/imagescaling)
endif

ifdef PTXCONF_QT4_EXAMPLES_MAPDEMO
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/qtconcurrent/map/mapdemo)
endif

ifdef PTXCONF_QT4_EXAMPLES_PROGRESSDIALOG
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/qtconcurrent/progressdialog/progressdialog)
endif

ifdef PTXCONF_QT4_EXAMPLES_RUNFUNCTION
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/qtconcurrent/runfunction/runfunction)
endif

ifdef PTXCONF_QT4_EXAMPLES_WORDCOUNT
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/qtconcurrent/wordcount/wordcount)
endif

ifdef PTXCONF_QT4_EXAMPLES_TUTORIAL1
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/qtestlib/tutorial1/tutorial1)
endif

ifdef PTXCONF_QT4_EXAMPLES_TUTORIAL2
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/qtestlib/tutorial2/tutorial2)
endif

ifdef PTXCONF_QT4_EXAMPLES_TUTORIAL3
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/qtestlib/tutorial3/tutorial3)
endif

ifdef PTXCONF_QT4_EXAMPLES_TUTORIAL4
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/qtestlib/tutorial4/tutorial4)
endif

ifdef PTXCONF_QT4_EXAMPLES_TUTORIAL5
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/qtestlib/tutorial5/tutorial5)
endif

ifdef PTXCONF_QT4_EXAMPLES_FRAMEBUFFER
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/qws/framebuffer/framebuffer)
endif

ifdef PTXCONF_QT4_EXAMPLES_MOUSECALIBRATION
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/qws/mousecalibration/mousecalibration)
endif

ifdef PTXCONF_QT4_EXAMPLES_SIMPLEDECORATION
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/qws/simpledecoration/simpledecoration)
endif

ifdef PTXCONF_QT4_EXAMPLES_CALENDAR
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/richtext/calendar/calendar)
endif

ifdef PTXCONF_QT4_EXAMPLES_ORDERFORM
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/richtext/orderform/orderform)
endif

ifdef PTXCONF_QT4_EXAMPLES_SYNTAXHIGHLIGHTER
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/richtext/syntaxhighlighter/syntaxhighlighter)
endif

ifdef PTXCONF_QT4_EXAMPLES_TEXTOBJECT
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/richtext/textobject/textobject)
endif

ifdef PTXCONF_QT4_EXAMPLES_CONTEXT2D
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/script/context2d/context2d)
endif

ifdef PTXCONF_QT4_EXAMPLES_CUSTOMCLASS
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/script/customclass/customclass)
endif

ifdef PTXCONF_QT4_EXAMPLES_DEFAULTPROTOTYPES
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/script/defaultprototypes/defaultprototypes)
endif

ifdef PTXCONF_QT4_EXAMPLES_HELLOSCRIPT
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/script/helloscript/helloscript)
endif

ifdef PTXCONF_QT4_EXAMPLES_MARSHAL
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/script/marshal/marshal)
endif

ifdef PTXCONF_QT4_EXAMPLES_QSCRIPT
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/script/qscript/qscript)
endif

ifdef PTXCONF_QT4_EXAMPLES_CACHEDTABLE
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/sql/cachedtable/cachedtable)
endif

ifdef PTXCONF_QT4_EXAMPLES_DRILLDOWN
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/sql/drilldown/drilldown)
endif

ifdef PTXCONF_QT4_EXAMPLES_MASTERDETAIL
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/sql/masterdetail/masterdetail)
endif

ifdef PTXCONF_QT4_EXAMPLES_QUERYMODEL
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/sql/querymodel/querymodel)
endif

ifdef PTXCONF_QT4_EXAMPLES_RELATIONALTABLEMODEL
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/sql/relationaltablemodel/relationaltablemodel)
endif

ifdef PTXCONF_QT4_EXAMPLES_SQLWIDGETMAPPER
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/sql/sqlwidgetmapper/sqlwidgetmapper)
endif

ifdef PTXCONF_QT4_EXAMPLES_TABLEMODEL
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/sql/tablemodel/tablemodel)
endif

ifdef PTXCONF_QT4_EXAMPLES_MANDELBROT
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/threads/mandelbrot/mandelbrot)
endif

ifdef PTXCONF_QT4_EXAMPLES_SEMAPHORES
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/threads/semaphores/semaphores)
endif

ifdef PTXCONF_QT4_EXAMPLES_WAITCONDITIONS
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/threads/waitconditions/waitconditions)
endif

ifdef PTXCONF_QT4_EXAMPLES_CODECS
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tools/codecs/codecs)
endif

ifdef PTXCONF_QT4_EXAMPLES_COMPLETER
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tools/completer/completer)
endif

ifdef PTXCONF_QT4_EXAMPLES_CUSTOMCOMPLETER
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tools/customcompleter/customcompleter)
endif

ifdef PTXCONF_QT4_EXAMPLES_ECHOPLUGIN
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tools/echoplugin/echowindow/../echoplugin)
endif

ifdef PTXCONF_QT4_EXAMPLES_I18N
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tools/i18n/i18n)
endif

ifdef PTXCONF_QT4_EXAMPLES_PLUGANDPAINT
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tools/plugandpaint/plugandpaint)
endif

ifdef PTXCONF_QT4_EXAMPLES_REGEXP
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tools/regexp/regexp)
endif

ifdef PTXCONF_QT4_EXAMPLES_SETTINGSEDITOR
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tools/settingseditor/settingseditor)
endif

ifdef PTXCONF_QT4_EXAMPLES_STYLEPLUGIN
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tools/styleplugin/stylewindow/../styleplugin)
endif

ifdef PTXCONF_QT4_EXAMPLES_TREEMODELCOMPLETER
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tools/treemodelcompleter/treemodelcompleter)
endif

ifdef PTXCONF_QT4_EXAMPLES_UNDOFRAMEWORK
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tools/undoframework/undoframework)
endif

ifdef PTXCONF_QT4_EXAMPLES_PART1
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tutorials/addressbook/part1/part1)
endif

ifdef PTXCONF_QT4_EXAMPLES_PART2
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tutorials/addressbook/part2/part2)
endif

ifdef PTXCONF_QT4_EXAMPLES_PART3
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tutorials/addressbook/part3/part3)
endif

ifdef PTXCONF_QT4_EXAMPLES_PART4
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tutorials/addressbook/part4/part4)
endif

ifdef PTXCONF_QT4_EXAMPLES_PART5
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tutorials/addressbook/part5/part5)
endif

ifdef PTXCONF_QT4_EXAMPLES_PART6
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tutorials/addressbook/part6/part6)
endif

ifdef PTXCONF_QT4_EXAMPLES_PART7
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tutorials/addressbook/part7/part7)
endif

ifdef PTXCONF_QT4_EXAMPLES_MULTIPLEINHERITANCE
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/uitools/multipleinheritance/multipleinheritance)
endif

ifdef PTXCONF_QT4_EXAMPLES_TEXTFINDER
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/uitools/textfinder/textfinder)
endif

ifdef PTXCONF_QT4_EXAMPLES_FANCYBROWSER
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/webkit/fancybrowser/fancybrowser)
endif

ifdef PTXCONF_QT4_EXAMPLES_FORMEXTRACTOR
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/webkit/formextractor/formextractor)
endif

ifdef PTXCONF_QT4_EXAMPLES_GOOGLECHAT
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/webkit/googlechat/googlechat)
endif

ifdef PTXCONF_QT4_EXAMPLES_PREVIEWER
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/webkit/previewer/previewer)
endif

ifdef PTXCONF_QT4_EXAMPLES_ANALOGCLOCK
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/widgets/analogclock/analogclock)
endif

ifdef PTXCONF_QT4_EXAMPLES_CALCULATOR
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/widgets/calculator/calculator)
endif

ifdef PTXCONF_QT4_EXAMPLES_CALENDARWIDGET
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/widgets/calendarwidget/calendarwidget)
endif

ifdef PTXCONF_QT4_EXAMPLES_CHARACTERMAP
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/widgets/charactermap/charactermap)
endif

ifdef PTXCONF_QT4_EXAMPLES_CODEEDITOR
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/widgets/codeeditor/codeeditor)
endif

ifdef PTXCONF_QT4_EXAMPLES_DIGITALCLOCK
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/widgets/digitalclock/digitalclock)
endif

ifdef PTXCONF_QT4_EXAMPLES_GROUPBOX
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/widgets/groupbox/groupbox)
endif

ifdef PTXCONF_QT4_EXAMPLES_ICONS
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/widgets/icons/icons)
endif

ifdef PTXCONF_QT4_EXAMPLES_IMAGEVIEWER
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/widgets/imageviewer/imageviewer)
endif

ifdef PTXCONF_QT4_EXAMPLES_LINEEDITS
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/widgets/lineedits/lineedits)
endif

ifdef PTXCONF_QT4_EXAMPLES_MOVIE
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/widgets/movie/movie)
endif

ifdef PTXCONF_QT4_EXAMPLES_SCRIBBLE
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/widgets/scribble/scribble)
endif

ifdef PTXCONF_QT4_EXAMPLES_SHAPEDCLOCK
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/widgets/shapedclock/shapedclock)
endif

ifdef PTXCONF_QT4_EXAMPLES_SLIDERS
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/widgets/sliders/sliders)
endif

ifdef PTXCONF_QT4_EXAMPLES_SPINBOXES
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/widgets/spinboxes/spinboxes)
endif

ifdef PTXCONF_QT4_EXAMPLES_STYLES
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/widgets/styles/styles)
endif

ifdef PTXCONF_QT4_EXAMPLES_STYLESHEET
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/widgets/stylesheet/stylesheet)
endif

ifdef PTXCONF_QT4_EXAMPLES_TABLET
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/widgets/tablet/tablet)
endif

ifdef PTXCONF_QT4_EXAMPLES_TETRIX
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/widgets/tetrix/tetrix)
endif

ifdef PTXCONF_QT4_EXAMPLES_TOOLTIPS
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/widgets/tooltips/tooltips)
endif

ifdef PTXCONF_QT4_EXAMPLES_VALIDATORS
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/widgets/validators/validators)
endif

ifdef PTXCONF_QT4_EXAMPLES_WIGGLY
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/widgets/wiggly/wiggly)
endif

ifdef PTXCONF_QT4_EXAMPLES_WINDOWFLAGS
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/widgets/windowflags/windowflags)
endif

ifdef PTXCONF_QT4_EXAMPLES_DOMBOOKMARKS
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/xml/dombookmarks/dombookmarks)
endif

ifdef PTXCONF_QT4_EXAMPLES_RSSLISTING
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/xml/rsslisting/rsslisting)
endif

ifdef PTXCONF_QT4_EXAMPLES_SAXBOOKMARKS
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/xml/saxbookmarks/saxbookmarks)
endif

ifdef PTXCONF_QT4_EXAMPLES_STREAMBOOKMARKS
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/xml/streambookmarks/streambookmarks)
endif

ifdef PTXCONF_QT4_EXAMPLES_XMLSTREAMLINT
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/xml/xmlstreamlint/xmlstreamlint)
endif

ifdef PTXCONF_QT4_EXAMPLES_FILETREE
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/xmlpatterns/filetree/filetree)
endif

ifdef PTXCONF_QT4_EXAMPLES_QOBJECTXMLMODEL
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/xmlpatterns/qobjectxmlmodel/qobjectxmlmodel)
endif

ifdef PTXCONF_QT4_EXAMPLES_RECIPES
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/xmlpatterns/recipes/recipes)
endif

ifdef PTXCONF_QT4_EXAMPLES_TRAFFICINFO
	@$(call install_copy, qt4-examples, 0, 0, 0755, -, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/xmlpatterns/trafficinfo/trafficinfo)
endif


	@$(call install_finish,qt4-examples)
	@$(call touch, $@)

