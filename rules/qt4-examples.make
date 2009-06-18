# WARNING: this file is generated with qt4_mk_examples.sh
# do not edit

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

ifdef PTXCONF_QT4_EXAMPLES__SIMPLETEXTVIEWER
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/assistant/simpletextviewer/simpletextviewer, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/simpletextviewer)
endif

ifdef PTXCONF_QT4_EXAMPLES__COMPLEXPING
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/dbus/complexpingpong/complexping, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/complexping)
endif

ifdef PTXCONF_QT4_EXAMPLES__COMPLEXPONG
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/dbus/complexpingpong/complexpong, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/complexpong)
endif

ifdef PTXCONF_QT4_EXAMPLES__DBUS_CHAT
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/dbus/dbus-chat/dbus-chat, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/dbus-chat)
endif

ifdef PTXCONF_QT4_EXAMPLES__LISTNAMES
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/dbus/listnames/listnames, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/listnames)
endif

ifdef PTXCONF_QT4_EXAMPLES__PING
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/dbus/pingpong/ping, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/ping)
endif

ifdef PTXCONF_QT4_EXAMPLES__PONG
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/dbus/pingpong/pong, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/pong)
endif

ifdef PTXCONF_QT4_EXAMPLES__CAR
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/dbus/remotecontrolledcar/car/car, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/car)
endif

ifdef PTXCONF_QT4_EXAMPLES__CONTROLLER
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/dbus/remotecontrolledcar/controller/controller, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/controller)
endif

ifdef PTXCONF_QT4_EXAMPLES__CALCULATORBUILDER
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/designer/calculatorbuilder/calculatorbuilder, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/calculatorbuilder)
endif

ifdef PTXCONF_QT4_EXAMPLES__CALCULATORFORM
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/designer/calculatorform/calculatorform, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/calculatorform)
endif

ifdef PTXCONF_QT4_EXAMPLES__WORLDTIMECLOCKBUILDER
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/designer/worldtimeclockbuilder/worldtimeclockbuilder, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/worldtimeclockbuilder)
endif

ifdef PTXCONF_QT4_EXAMPLES__SCREENSHOT
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/desktop/screenshot/screenshot, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/screenshot)
endif

ifdef PTXCONF_QT4_EXAMPLES__SYSTRAY
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/desktop/systray/systray, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/systray)
endif

ifdef PTXCONF_QT4_EXAMPLES__CLASSWIZARD
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/dialogs/classwizard/classwizard, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/classwizard)
endif

ifdef PTXCONF_QT4_EXAMPLES__CONFIGDIALOG
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/dialogs/configdialog/configdialog, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/configdialog)
endif

ifdef PTXCONF_QT4_EXAMPLES__EXTENSION
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/dialogs/extension/extension, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/extension)
endif

ifdef PTXCONF_QT4_EXAMPLES__FINDFILES
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/dialogs/findfiles/findfiles, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/findfiles)
endif

ifdef PTXCONF_QT4_EXAMPLES__LICENSEWIZARD
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/dialogs/licensewizard/licensewizard, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/licensewizard)
endif

ifdef PTXCONF_QT4_EXAMPLES__STANDARDDIALOGS
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/dialogs/standarddialogs/standarddialogs, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/standarddialogs)
endif

ifdef PTXCONF_QT4_EXAMPLES__TABDIALOG
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/dialogs/tabdialog/tabdialog, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/tabdialog)
endif

ifdef PTXCONF_QT4_EXAMPLES__TRIVIALWIZARD
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/dialogs/trivialwizard/trivialwizard, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/trivialwizard)
endif

ifdef PTXCONF_QT4_EXAMPLES__DELAYEDENCODING
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/draganddrop/delayedencoding/delayedencoding, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/delayedencoding)
endif

ifdef PTXCONF_QT4_EXAMPLES__DRAGGABLEICONS
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/draganddrop/draggableicons/draggableicons, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/draggableicons)
endif

ifdef PTXCONF_QT4_EXAMPLES__DRAGGABLETEXT
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/draganddrop/draggabletext/draggabletext, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/draggabletext)
endif

ifdef PTXCONF_QT4_EXAMPLES__DROPSITE
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/draganddrop/dropsite/dropsite, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/dropsite)
endif

ifdef PTXCONF_QT4_EXAMPLES__FRIDGEMAGNETS
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/draganddrop/fridgemagnets/fridgemagnets, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/fridgemagnets)
endif

ifdef PTXCONF_QT4_EXAMPLES__PUZZLE
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/draganddrop/puzzle/puzzle, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/puzzle)
endif

ifdef PTXCONF_QT4_EXAMPLES__BASICGRAPHICSLAYOUTS
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/graphicsview/basicgraphicslayouts/basicgraphicslayouts, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/basicgraphicslayouts)
endif

ifdef PTXCONF_QT4_EXAMPLES__COLLIDINGMICE
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/graphicsview/collidingmice/collidingmice, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/collidingmice)
endif

ifdef PTXCONF_QT4_EXAMPLES__DIAGRAMSCENE
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/graphicsview/diagramscene/diagramscene, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/diagramscene)
endif

ifdef PTXCONF_QT4_EXAMPLES__DRAGDROPROBOT
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/graphicsview/dragdroprobot/dragdroprobot, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/dragdroprobot)
endif

ifdef PTXCONF_QT4_EXAMPLES__ELASTICNODES
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/graphicsview/elasticnodes/elasticnodes, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/elasticnodes)
endif

ifdef PTXCONF_QT4_EXAMPLES__PADNAVIGATOR
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/graphicsview/padnavigator/padnavigator, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/padnavigator)
endif

ifdef PTXCONF_QT4_EXAMPLES__CONTEXTSENSITIVEHELP
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/help/contextsensitivehelp/contextsensitivehelp, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/contextsensitivehelp)
endif

ifdef PTXCONF_QT4_EXAMPLES__REMOTECONTROL
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/help/remotecontrol/remotecontrol, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/remotecontrol)
endif

ifdef PTXCONF_QT4_EXAMPLES__SIMPLETEXTVIEWER
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/help/simpletextviewer/simpletextviewer, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/simpletextviewer)
endif

ifdef PTXCONF_QT4_EXAMPLES__LOCALFORTUNECLIENT
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/ipc/localfortuneclient/localfortuneclient, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/localfortuneclient)
endif

ifdef PTXCONF_QT4_EXAMPLES__LOCALFORTUNESERVER
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/ipc/localfortuneserver/localfortuneserver, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/localfortuneserver)
endif

ifdef PTXCONF_QT4_EXAMPLES__SHAREDMEMORY
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/ipc/sharedmemory/sharedmemory, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/sharedmemory)
endif

ifdef PTXCONF_QT4_EXAMPLES__ADDRESSBOOK
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/itemviews/addressbook/addressbook, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/addressbook)
endif

ifdef PTXCONF_QT4_EXAMPLES__BASICSORTFILTERMODEL
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/itemviews/basicsortfiltermodel/basicsortfiltermodel, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/basicsortfiltermodel)
endif

ifdef PTXCONF_QT4_EXAMPLES__CHART
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/itemviews/chart/chart, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/chart)
endif

ifdef PTXCONF_QT4_EXAMPLES__COLOREDITORFACTORY
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/itemviews/coloreditorfactory/coloreditorfactory, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/coloreditorfactory)
endif

ifdef PTXCONF_QT4_EXAMPLES__COMBOWIDGETMAPPER
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/itemviews/combowidgetmapper/combowidgetmapper, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/combowidgetmapper)
endif

ifdef PTXCONF_QT4_EXAMPLES__CUSTOMSORTFILTERMODEL
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/itemviews/customsortfiltermodel/customsortfiltermodel, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/customsortfiltermodel)
endif

ifdef PTXCONF_QT4_EXAMPLES__DIRVIEW
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/itemviews/dirview/dirview, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/dirview)
endif

ifdef PTXCONF_QT4_EXAMPLES__EDITABLETREEMODEL
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/itemviews/editabletreemodel/editabletreemodel, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/editabletreemodel)
endif

ifdef PTXCONF_QT4_EXAMPLES__FETCHMORE
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/itemviews/fetchmore/fetchmore, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/fetchmore)
endif

ifdef PTXCONF_QT4_EXAMPLES__PIXELATOR
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/itemviews/pixelator/pixelator, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/pixelator)
endif

ifdef PTXCONF_QT4_EXAMPLES__PUZZLE
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/itemviews/puzzle/puzzle, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/puzzle)
endif

ifdef PTXCONF_QT4_EXAMPLES__SIMPLEDOMMODEL
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/itemviews/simpledommodel/simpledommodel, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/simpledommodel)
endif

ifdef PTXCONF_QT4_EXAMPLES__SIMPLETREEMODEL
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/itemviews/simpletreemodel/simpletreemodel, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/simpletreemodel)
endif

ifdef PTXCONF_QT4_EXAMPLES__SIMPLEWIDGETMAPPER
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/itemviews/simplewidgetmapper/simplewidgetmapper, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/simplewidgetmapper)
endif

ifdef PTXCONF_QT4_EXAMPLES__SPINBOXDELEGATE
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/itemviews/spinboxdelegate/spinboxdelegate, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/spinboxdelegate)
endif

ifdef PTXCONF_QT4_EXAMPLES__STARDELEGATE
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/itemviews/stardelegate/stardelegate, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/stardelegate)
endif

ifdef PTXCONF_QT4_EXAMPLES__BASICLAYOUTS
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/layouts/basiclayouts/basiclayouts, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/basiclayouts)
endif

ifdef PTXCONF_QT4_EXAMPLES__BORDERLAYOUT
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/layouts/borderlayout/borderlayout, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/borderlayout)
endif

ifdef PTXCONF_QT4_EXAMPLES__DYNAMICLAYOUTS
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/layouts/dynamiclayouts/dynamiclayouts, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/dynamiclayouts)
endif

ifdef PTXCONF_QT4_EXAMPLES__FLOWLAYOUT
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/layouts/flowlayout/flowlayout, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/flowlayout)
endif

ifdef PTXCONF_QT4_EXAMPLES__ARROWPAD
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/linguist/arrowpad/arrowpad, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/arrowpad)
endif

ifdef PTXCONF_QT4_EXAMPLES__HELLOTR
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/linguist/hellotr/hellotr, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/hellotr)
endif

ifdef PTXCONF_QT4_EXAMPLES__TROLLPRINT
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/linguist/trollprint/trollprint, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/trollprint)
endif

ifdef PTXCONF_QT4_EXAMPLES__APPLICATION
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/mainwindows/application/application, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/application)
endif

ifdef PTXCONF_QT4_EXAMPLES__DOCKWIDGETS
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/mainwindows/dockwidgets/dockwidgets, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/dockwidgets)
endif

ifdef PTXCONF_QT4_EXAMPLES__MDI
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/mainwindows/mdi/mdi, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/mdi)
endif

ifdef PTXCONF_QT4_EXAMPLES__MENUS
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/mainwindows/menus/menus, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/menus)
endif

ifdef PTXCONF_QT4_EXAMPLES__RECENTFILES
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/mainwindows/recentfiles/recentfiles, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/recentfiles)
endif

ifdef PTXCONF_QT4_EXAMPLES__SDI
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/mainwindows/sdi/sdi, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/sdi)
endif

ifdef PTXCONF_QT4_EXAMPLES__BLOCKINGFORTUNECLIENT
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/network/blockingfortuneclient/blockingfortuneclient, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/blockingfortuneclient)
endif

ifdef PTXCONF_QT4_EXAMPLES__BROADCASTRECEIVER
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/network/broadcastreceiver/broadcastreceiver, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/broadcastreceiver)
endif

ifdef PTXCONF_QT4_EXAMPLES__BROADCASTSENDER
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/network/broadcastsender/broadcastsender, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/broadcastsender)
endif

ifdef PTXCONF_QT4_EXAMPLES__DOWNLOAD
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/network/download/download, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/download)
endif

ifdef PTXCONF_QT4_EXAMPLES__DOWNLOADMANAGER
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/network/downloadmanager/downloadmanager, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/downloadmanager)
endif

ifdef PTXCONF_QT4_EXAMPLES__FORTUNECLIENT
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/network/fortuneclient/fortuneclient, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/fortuneclient)
endif

ifdef PTXCONF_QT4_EXAMPLES__FORTUNESERVER
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/network/fortuneserver/fortuneserver, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/fortuneserver)
endif

ifdef PTXCONF_QT4_EXAMPLES__FTP
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/network/ftp/ftp, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/ftp)
endif

ifdef PTXCONF_QT4_EXAMPLES__HTTP
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/network/http/http, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/http)
endif

ifdef PTXCONF_QT4_EXAMPLES__LOOPBACK
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/network/loopback/loopback, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/loopback)
endif

ifdef PTXCONF_QT4_EXAMPLES__NETWORK_CHAT
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/network/network-chat/network-chat, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/network-chat)
endif

ifdef PTXCONF_QT4_EXAMPLES__THREADEDFORTUNESERVER
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/network/threadedfortuneserver/threadedfortuneserver, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/threadedfortuneserver)
endif

ifdef PTXCONF_QT4_EXAMPLES__TORRENT
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/network/torrent/torrent, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/torrent)
endif

ifdef PTXCONF_QT4_EXAMPLES__2DPAINTING
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/opengl/2dpainting/2dpainting, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/2dpainting)
endif

ifdef PTXCONF_QT4_EXAMPLES__FRAMEBUFFEROBJECT
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/opengl/framebufferobject/framebufferobject, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/framebufferobject)
endif

ifdef PTXCONF_QT4_EXAMPLES__FRAMEBUFFEROBJECT2
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/opengl/framebufferobject2/framebufferobject2, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/framebufferobject2)
endif

ifdef PTXCONF_QT4_EXAMPLES__GRABBER
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/opengl/grabber/grabber, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/grabber)
endif

ifdef PTXCONF_QT4_EXAMPLES__HELLOGL
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/opengl/hellogl/hellogl, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/hellogl)
endif

ifdef PTXCONF_QT4_EXAMPLES__OVERPAINTING
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/opengl/overpainting/overpainting, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/overpainting)
endif

ifdef PTXCONF_QT4_EXAMPLES__PBUFFERS
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/opengl/pbuffers/pbuffers, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/pbuffers)
endif

ifdef PTXCONF_QT4_EXAMPLES__PBUFFERS2
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/opengl/pbuffers2/pbuffers2, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/pbuffers2)
endif

ifdef PTXCONF_QT4_EXAMPLES__SAMPLEBUFFERS
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/opengl/samplebuffers/samplebuffers, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/samplebuffers)
endif

ifdef PTXCONF_QT4_EXAMPLES__TEXTURES
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/opengl/textures/textures, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/textures)
endif

ifdef PTXCONF_QT4_EXAMPLES__BASICDRAWING
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/painting/basicdrawing/basicdrawing, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/basicdrawing)
endif

ifdef PTXCONF_QT4_EXAMPLES__CONCENTRICCIRCLES
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/painting/concentriccircles/concentriccircles, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/concentriccircles)
endif

ifdef PTXCONF_QT4_EXAMPLES__FONTSAMPLER
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/painting/fontsampler/fontsampler, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/fontsampler)
endif

ifdef PTXCONF_QT4_EXAMPLES__IMAGECOMPOSITION
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/painting/imagecomposition/imagecomposition, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/imagecomposition)
endif

ifdef PTXCONF_QT4_EXAMPLES__PAINTERPATHS
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/painting/painterpaths/painterpaths, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/painterpaths)
endif

ifdef PTXCONF_QT4_EXAMPLES__SVGGENERATOR
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/painting/svggenerator/svggenerator, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/svggenerator)
endif

ifdef PTXCONF_QT4_EXAMPLES__SVGVIEWER
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/painting/svgviewer/svgviewer, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/svgviewer)
endif

ifdef PTXCONF_QT4_EXAMPLES__TRANSFORMATIONS
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/painting/transformations/transformations, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/transformations)
endif

ifdef PTXCONF_QT4_EXAMPLES__CAPABILITIES
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/phonon/capabilities/capabilities, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/capabilities)
endif

ifdef PTXCONF_QT4_EXAMPLES__MUSICPLAYER
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/phonon/musicplayer/musicplayer, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/musicplayer)
endif

ifdef PTXCONF_QT4_EXAMPLES__IMAGESCALING
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/qtconcurrent/imagescaling/imagescaling, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/imagescaling)
endif

ifdef PTXCONF_QT4_EXAMPLES__MAPDEMO
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/qtconcurrent/map/mapdemo, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/mapdemo)
endif

ifdef PTXCONF_QT4_EXAMPLES__PROGRESSDIALOG
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/qtconcurrent/progressdialog/progressdialog, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/progressdialog)
endif

ifdef PTXCONF_QT4_EXAMPLES__RUNFUNCTION
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/qtconcurrent/runfunction/runfunction, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/runfunction)
endif

ifdef PTXCONF_QT4_EXAMPLES__WORDCOUNT
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/qtconcurrent/wordcount/wordcount, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/wordcount)
endif

ifdef PTXCONF_QT4_EXAMPLES__TUTORIAL1
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/qtestlib/tutorial1/tutorial1, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/tutorial1)
endif

ifdef PTXCONF_QT4_EXAMPLES__TUTORIAL2
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/qtestlib/tutorial2/tutorial2, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/tutorial2)
endif

ifdef PTXCONF_QT4_EXAMPLES__TUTORIAL3
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/qtestlib/tutorial3/tutorial3, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/tutorial3)
endif

ifdef PTXCONF_QT4_EXAMPLES__TUTORIAL4
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/qtestlib/tutorial4/tutorial4, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/tutorial4)
endif

ifdef PTXCONF_QT4_EXAMPLES__TUTORIAL5
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/qtestlib/tutorial5/tutorial5, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/tutorial5)
endif

ifdef PTXCONF_QT4_EXAMPLES__FRAMEBUFFER
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/qws/framebuffer/framebuffer, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/framebuffer)
endif

ifdef PTXCONF_QT4_EXAMPLES__MOUSECALIBRATION
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/qws/mousecalibration/mousecalibration, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/mousecalibration)
endif

ifdef PTXCONF_QT4_EXAMPLES__SIMPLEDECORATION
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/qws/simpledecoration/simpledecoration, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/simpledecoration)
endif

ifdef PTXCONF_QT4_EXAMPLES__CALENDAR
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/richtext/calendar/calendar, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/calendar)
endif

ifdef PTXCONF_QT4_EXAMPLES__ORDERFORM
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/richtext/orderform/orderform, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/orderform)
endif

ifdef PTXCONF_QT4_EXAMPLES__SYNTAXHIGHLIGHTER
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/richtext/syntaxhighlighter/syntaxhighlighter, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/syntaxhighlighter)
endif

ifdef PTXCONF_QT4_EXAMPLES__TEXTOBJECT
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/richtext/textobject/textobject, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/textobject)
endif

ifdef PTXCONF_QT4_EXAMPLES__CONTEXT2D
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/script/context2d/context2d, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/context2d)
endif

ifdef PTXCONF_QT4_EXAMPLES__CUSTOMCLASS
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/script/customclass/customclass, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/customclass)
endif

ifdef PTXCONF_QT4_EXAMPLES__DEFAULTPROTOTYPES
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/script/defaultprototypes/defaultprototypes, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/defaultprototypes)
endif

ifdef PTXCONF_QT4_EXAMPLES__HELLOSCRIPT
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/script/helloscript/helloscript, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/helloscript)
endif

ifdef PTXCONF_QT4_EXAMPLES__MARSHAL
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/script/marshal/marshal, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/marshal)
endif

ifdef PTXCONF_QT4_EXAMPLES__QSCRIPT
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/script/qscript/qscript, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/qscript)
endif

ifdef PTXCONF_QT4_EXAMPLES__CACHEDTABLE
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/sql/cachedtable/cachedtable, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/cachedtable)
endif

ifdef PTXCONF_QT4_EXAMPLES__DRILLDOWN
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/sql/drilldown/drilldown, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/drilldown)
endif

ifdef PTXCONF_QT4_EXAMPLES__MASTERDETAIL
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/sql/masterdetail/masterdetail, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/masterdetail)
endif

ifdef PTXCONF_QT4_EXAMPLES__QUERYMODEL
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/sql/querymodel/querymodel, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/querymodel)
endif

ifdef PTXCONF_QT4_EXAMPLES__RELATIONALTABLEMODEL
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/sql/relationaltablemodel/relationaltablemodel, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/relationaltablemodel)
endif

ifdef PTXCONF_QT4_EXAMPLES__SQLWIDGETMAPPER
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/sql/sqlwidgetmapper/sqlwidgetmapper, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/sqlwidgetmapper)
endif

ifdef PTXCONF_QT4_EXAMPLES__TABLEMODEL
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/sql/tablemodel/tablemodel, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/tablemodel)
endif

ifdef PTXCONF_QT4_EXAMPLES__MANDELBROT
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/threads/mandelbrot/mandelbrot, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/mandelbrot)
endif

ifdef PTXCONF_QT4_EXAMPLES__SEMAPHORES
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/threads/semaphores/semaphores, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/semaphores)
endif

ifdef PTXCONF_QT4_EXAMPLES__WAITCONDITIONS
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/threads/waitconditions/waitconditions, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/waitconditions)
endif

ifdef PTXCONF_QT4_EXAMPLES__CODECS
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/tools/codecs/codecs, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/codecs)
endif

ifdef PTXCONF_QT4_EXAMPLES__COMPLETER
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/tools/completer/completer, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/completer)
endif

ifdef PTXCONF_QT4_EXAMPLES__CUSTOMCOMPLETER
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/tools/customcompleter/customcompleter, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/customcompleter)
endif

ifdef PTXCONF_QT4_EXAMPLES__ECHOPLUGIN
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/tools/echoplugin/echowindow/echoplugin, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/echoplugin)
endif

ifdef PTXCONF_QT4_EXAMPLES__I18N
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/tools/i18n/i18n, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/i18n)
endif

ifdef PTXCONF_QT4_EXAMPLES__PLUGANDPAINT
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/tools/plugandpaint/plugandpaint, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/plugandpaint)
endif

ifdef PTXCONF_QT4_EXAMPLES__REGEXP
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/tools/regexp/regexp, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/regexp)
endif

ifdef PTXCONF_QT4_EXAMPLES__SETTINGSEDITOR
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/tools/settingseditor/settingseditor, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/settingseditor)
endif

ifdef PTXCONF_QT4_EXAMPLES__STYLEPLUGIN
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/tools/styleplugin/stylewindow/styleplugin, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/styleplugin)
endif

ifdef PTXCONF_QT4_EXAMPLES__TREEMODELCOMPLETER
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/tools/treemodelcompleter/treemodelcompleter, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/treemodelcompleter)
endif

ifdef PTXCONF_QT4_EXAMPLES__UNDOFRAMEWORK
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/tools/undoframework/undoframework, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/undoframework)
endif

ifdef PTXCONF_QT4_EXAMPLES__PART1
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/tutorials/addressbook-fr/part1/part1, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/part1)
endif

ifdef PTXCONF_QT4_EXAMPLES__PART2
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/tutorials/addressbook-fr/part2/part2, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/part2)
endif

ifdef PTXCONF_QT4_EXAMPLES__PART3
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/tutorials/addressbook-fr/part3/part3, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/part3)
endif

ifdef PTXCONF_QT4_EXAMPLES__PART4
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/tutorials/addressbook-fr/part4/part4, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/part4)
endif

ifdef PTXCONF_QT4_EXAMPLES__PART5
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/tutorials/addressbook-fr/part5/part5, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/part5)
endif

ifdef PTXCONF_QT4_EXAMPLES__PART6
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/tutorials/addressbook-fr/part6/part6, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/part6)
endif

ifdef PTXCONF_QT4_EXAMPLES__PART7
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/tutorials/addressbook-fr/part7/part7, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/part7)
endif

ifdef PTXCONF_QT4_EXAMPLES__PART1
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/tutorials/addressbook/part1/part1, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/part1)
endif

ifdef PTXCONF_QT4_EXAMPLES__PART2
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/tutorials/addressbook/part2/part2, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/part2)
endif

ifdef PTXCONF_QT4_EXAMPLES__PART3
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/tutorials/addressbook/part3/part3, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/part3)
endif

ifdef PTXCONF_QT4_EXAMPLES__PART4
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/tutorials/addressbook/part4/part4, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/part4)
endif

ifdef PTXCONF_QT4_EXAMPLES__PART5
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/tutorials/addressbook/part5/part5, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/part5)
endif

ifdef PTXCONF_QT4_EXAMPLES__PART6
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/tutorials/addressbook/part6/part6, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/part6)
endif

ifdef PTXCONF_QT4_EXAMPLES__PART7
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/tutorials/addressbook/part7/part7, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/part7)
endif

ifdef PTXCONF_QT4_EXAMPLES__MULTIPLEINHERITANCE
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/uitools/multipleinheritance/multipleinheritance, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/multipleinheritance)
endif

ifdef PTXCONF_QT4_EXAMPLES__TEXTFINDER
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/uitools/textfinder/textfinder, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/textfinder)
endif

ifdef PTXCONF_QT4_EXAMPLES__FORMEXTRACTOR
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/webkit/formextractor/formExtractor, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/formExtractor)
endif

ifdef PTXCONF_QT4_EXAMPLES__PREVIEWER
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/webkit/previewer/previewer, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/previewer)
endif

ifdef PTXCONF_QT4_EXAMPLES__ANALOGCLOCK
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/widgets/analogclock/analogclock, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/analogclock)
endif

ifdef PTXCONF_QT4_EXAMPLES__CALCULATOR
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/widgets/calculator/calculator, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/calculator)
endif

ifdef PTXCONF_QT4_EXAMPLES__CALENDARWIDGET
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/widgets/calendarwidget/calendarwidget, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/calendarwidget)
endif

ifdef PTXCONF_QT4_EXAMPLES__CHARACTERMAP
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/widgets/charactermap/charactermap, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/charactermap)
endif

ifdef PTXCONF_QT4_EXAMPLES__CODEEDITOR
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/widgets/codeeditor/codeeditor, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/codeeditor)
endif

ifdef PTXCONF_QT4_EXAMPLES__DIGITALCLOCK
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/widgets/digitalclock/digitalclock, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/digitalclock)
endif

ifdef PTXCONF_QT4_EXAMPLES__GROUPBOX
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/widgets/groupbox/groupbox, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/groupbox)
endif

ifdef PTXCONF_QT4_EXAMPLES__ICONS
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/widgets/icons/icons, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/icons)
endif

ifdef PTXCONF_QT4_EXAMPLES__IMAGEVIEWER
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/widgets/imageviewer/imageviewer, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/imageviewer)
endif

ifdef PTXCONF_QT4_EXAMPLES__LINEEDITS
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/widgets/lineedits/lineedits, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/lineedits)
endif

ifdef PTXCONF_QT4_EXAMPLES__MOVIE
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/widgets/movie/movie, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/movie)
endif

ifdef PTXCONF_QT4_EXAMPLES__SCRIBBLE
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/widgets/scribble/scribble, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/scribble)
endif

ifdef PTXCONF_QT4_EXAMPLES__SHAPEDCLOCK
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/widgets/shapedclock/shapedclock, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/shapedclock)
endif

ifdef PTXCONF_QT4_EXAMPLES__SLIDERS
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/widgets/sliders/sliders, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/sliders)
endif

ifdef PTXCONF_QT4_EXAMPLES__SPINBOXES
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/widgets/spinboxes/spinboxes, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/spinboxes)
endif

ifdef PTXCONF_QT4_EXAMPLES__STYLES
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/widgets/styles/styles, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/styles)
endif

ifdef PTXCONF_QT4_EXAMPLES__STYLESHEET
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/widgets/stylesheet/stylesheet, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/stylesheet)
endif

ifdef PTXCONF_QT4_EXAMPLES__TABLET
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/widgets/tablet/tablet, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/tablet)
endif

ifdef PTXCONF_QT4_EXAMPLES__TETRIX
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/widgets/tetrix/tetrix, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/tetrix)
endif

ifdef PTXCONF_QT4_EXAMPLES__TOOLTIPS
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/widgets/tooltips/tooltips, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/tooltips)
endif

ifdef PTXCONF_QT4_EXAMPLES__VALIDATORS
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/widgets/validators/validators, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/validators)
endif

ifdef PTXCONF_QT4_EXAMPLES__WIGGLY
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/widgets/wiggly/wiggly, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/wiggly)
endif

ifdef PTXCONF_QT4_EXAMPLES__WINDOWFLAGS
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/widgets/windowflags/windowflags, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/windowflags)
endif

ifdef PTXCONF_QT4_EXAMPLES__DOMBOOKMARKS
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/xml/dombookmarks/dombookmarks, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/dombookmarks)
endif

ifdef PTXCONF_QT4_EXAMPLES__RSSLISTING
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/xml/rsslisting/rsslisting, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/rsslisting)
endif

ifdef PTXCONF_QT4_EXAMPLES__SAXBOOKMARKS
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/xml/saxbookmarks/saxbookmarks, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/saxbookmarks)
endif

ifdef PTXCONF_QT4_EXAMPLES__STREAMBOOKMARKS
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/xml/streambookmarks/streambookmarks, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/streambookmarks)
endif

ifdef PTXCONF_QT4_EXAMPLES__XMLSTREAMLINT
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/xml/xmlstreamlint/xmlstreamlint, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/xmlstreamlint)
endif

ifdef PTXCONF_QT4_EXAMPLES__FILETREE
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/xmlpatterns/filetree/filetree, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/filetree)
endif

ifdef PTXCONF_QT4_EXAMPLES__QOBJECTXMLMODEL
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/xmlpatterns/qobjectxmlmodel/qobjectxmlmodel, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/qobjectxmlmodel)
endif

ifdef PTXCONF_QT4_EXAMPLES__RECIPES
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/xmlpatterns/recipes/recipes, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/recipes)
endif

ifdef PTXCONF_QT4_EXAMPLES__TRAFFICINFO
	@$(call install_copy, qt4-examples, 0, 0, 0644, \
		$(QT4_DIR)/examples/xmlpatterns/trafficinfo/trafficinfo, \
		$(PTXCONF_QT4_EXAMPLES__INSTALL_DIR)/trafficinfo)
endif


	@$(call install_finish,qt4-examples)
	@$(call touch, $@)

