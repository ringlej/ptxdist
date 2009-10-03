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

ifdef PTXCONF_QT4_EXAMPLES_SIMPLETEXTVIEWER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/assistant/simpletextviewer/simpletextviewer, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/simpletextviewer)
endif

ifdef PTXCONF_QT4_EXAMPLES_COMPLEXPING
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/dbus/complexpingpong/complexping, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/complexping)
endif

ifdef PTXCONF_QT4_EXAMPLES_COMPLEXPONG
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/dbus/complexpingpong/complexping, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/complexpong)
endif

ifdef PTXCONF_QT4_EXAMPLES_DBUS_CHAT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/dbus/dbus-chat/dbus-chat, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/dbus-chat)
endif

ifdef PTXCONF_QT4_EXAMPLES_LISTNAMES
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/dbus/listnames/listnames, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/listnames)
endif

ifdef PTXCONF_QT4_EXAMPLES_PING
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/dbus/pingpong/pong, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/ping)
endif

ifdef PTXCONF_QT4_EXAMPLES_PONG
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/dbus/pingpong/pong, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/pong)
endif

ifdef PTXCONF_QT4_EXAMPLES_CAR
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/dbus/remotecontrolledcar/car/car, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/car)
endif

ifdef PTXCONF_QT4_EXAMPLES_CONTROLLER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/dbus/remotecontrolledcar/controller/controller, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/controller)
endif

ifdef PTXCONF_QT4_EXAMPLES_CALCULATORBUILDER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/designer/calculatorbuilder/calculatorbuilder, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/calculatorbuilder)
endif

ifdef PTXCONF_QT4_EXAMPLES_CALCULATORFORM
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/designer/calculatorform/calculatorform, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/calculatorform)
endif

ifdef PTXCONF_QT4_EXAMPLES_WORLDTIMECLOCKBUILDER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/designer/worldtimeclockbuilder/worldtimeclockbuilder, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/worldtimeclockbuilder)
endif

ifdef PTXCONF_QT4_EXAMPLES_SCREENSHOT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/desktop/screenshot/screenshot, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/screenshot)
endif

ifdef PTXCONF_QT4_EXAMPLES_SYSTRAY
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/desktop/systray/systray, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/systray)
endif

ifdef PTXCONF_QT4_EXAMPLES_CLASSWIZARD
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/dialogs/classwizard/classwizard, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/classwizard)
endif

ifdef PTXCONF_QT4_EXAMPLES_CONFIGDIALOG
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/dialogs/configdialog/configdialog, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/configdialog)
endif

ifdef PTXCONF_QT4_EXAMPLES_EXTENSION
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/dialogs/extension/extension, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/extension)
endif

ifdef PTXCONF_QT4_EXAMPLES_FINDFILES
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/dialogs/findfiles/findfiles, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/findfiles)
endif

ifdef PTXCONF_QT4_EXAMPLES_LICENSEWIZARD
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/dialogs/licensewizard/licensewizard, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/licensewizard)
endif

ifdef PTXCONF_QT4_EXAMPLES_STANDARDDIALOGS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/dialogs/standarddialogs/standarddialogs, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/standarddialogs)
endif

ifdef PTXCONF_QT4_EXAMPLES_TABDIALOG
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/dialogs/tabdialog/tabdialog, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tabdialog)
endif

ifdef PTXCONF_QT4_EXAMPLES_TRIVIALWIZARD
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/dialogs/trivialwizard/trivialwizard, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/trivialwizard)
endif

ifdef PTXCONF_QT4_EXAMPLES_DELAYEDENCODING
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/draganddrop/delayedencoding/delayedencoding, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/delayedencoding)
endif

ifdef PTXCONF_QT4_EXAMPLES_DRAGGABLEICONS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/draganddrop/draggableicons/draggableicons, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/draggableicons)
endif

ifdef PTXCONF_QT4_EXAMPLES_DRAGGABLETEXT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/draganddrop/draggabletext/draggabletext, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/draggabletext)
endif

ifdef PTXCONF_QT4_EXAMPLES_DROPSITE
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/draganddrop/dropsite/dropsite, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/dropsite)
endif

ifdef PTXCONF_QT4_EXAMPLES_FRIDGEMAGNETS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/draganddrop/fridgemagnets/fridgemagnets, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/fridgemagnets)
endif

ifdef PTXCONF_QT4_EXAMPLES_PUZZLE
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/draganddrop/puzzle/puzzle, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/puzzle)
endif

ifdef PTXCONF_QT4_EXAMPLES_BASICGRAPHICSLAYOUTS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/graphicsview/basicgraphicslayouts/basicgraphicslayouts, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/basicgraphicslayouts)
endif

ifdef PTXCONF_QT4_EXAMPLES_COLLIDINGMICE
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/graphicsview/collidingmice/collidingmice, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/collidingmice)
endif

ifdef PTXCONF_QT4_EXAMPLES_DIAGRAMSCENE
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/graphicsview/diagramscene/diagramscene, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/diagramscene)
endif

ifdef PTXCONF_QT4_EXAMPLES_DRAGDROPROBOT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/graphicsview/dragdroprobot/dragdroprobot, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/dragdroprobot)
endif

ifdef PTXCONF_QT4_EXAMPLES_ELASTICNODES
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/graphicsview/elasticnodes/elasticnodes, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/elasticnodes)
endif

ifdef PTXCONF_QT4_EXAMPLES_PADNAVIGATOR
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/graphicsview/padnavigator/padnavigator, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/padnavigator)
endif

ifdef PTXCONF_QT4_EXAMPLES_CONTEXTSENSITIVEHELP
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/help/contextsensitivehelp/contextsensitivehelp, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/contextsensitivehelp)
endif

ifdef PTXCONF_QT4_EXAMPLES_REMOTECONTROL
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/help/remotecontrol/remotecontrol, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/remotecontrol)
endif

ifdef PTXCONF_QT4_EXAMPLES_SIMPLETEXTVIEWER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/help/simpletextviewer/simpletextviewer, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/simpletextviewer)
endif

ifdef PTXCONF_QT4_EXAMPLES_LOCALFORTUNECLIENT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/ipc/localfortuneclient/localfortuneclient, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/localfortuneclient)
endif

ifdef PTXCONF_QT4_EXAMPLES_LOCALFORTUNESERVER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/ipc/localfortuneserver/localfortuneserver, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/localfortuneserver)
endif

ifdef PTXCONF_QT4_EXAMPLES_SHAREDMEMORY
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/ipc/sharedmemory/sharedmemory, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/sharedmemory)
endif

ifdef PTXCONF_QT4_EXAMPLES_ADDRESSBOOK
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/itemviews/addressbook/addressbook, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/addressbook)
endif

ifdef PTXCONF_QT4_EXAMPLES_BASICSORTFILTERMODEL
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/itemviews/basicsortfiltermodel/basicsortfiltermodel, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/basicsortfiltermodel)
endif

ifdef PTXCONF_QT4_EXAMPLES_CHART
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/itemviews/chart/chart, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/chart)
endif

ifdef PTXCONF_QT4_EXAMPLES_COLOREDITORFACTORY
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/itemviews/coloreditorfactory/coloreditorfactory, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/coloreditorfactory)
endif

ifdef PTXCONF_QT4_EXAMPLES_COMBOWIDGETMAPPER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/itemviews/combowidgetmapper/combowidgetmapper, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/combowidgetmapper)
endif

ifdef PTXCONF_QT4_EXAMPLES_CUSTOMSORTFILTERMODEL
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/itemviews/customsortfiltermodel/customsortfiltermodel, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/customsortfiltermodel)
endif

ifdef PTXCONF_QT4_EXAMPLES_DIRVIEW
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/itemviews/dirview/dirview, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/dirview)
endif

ifdef PTXCONF_QT4_EXAMPLES_EDITABLETREEMODEL
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/itemviews/editabletreemodel/editabletreemodel, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/editabletreemodel)
endif

ifdef PTXCONF_QT4_EXAMPLES_FETCHMORE
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/itemviews/fetchmore/fetchmore, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/fetchmore)
endif

ifdef PTXCONF_QT4_EXAMPLES_FROZENCOLUMN
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/itemviews/frozencolumn/frozencolumn, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/frozencolumn)
endif

ifdef PTXCONF_QT4_EXAMPLES_PIXELATOR
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/itemviews/pixelator/pixelator, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/pixelator)
endif

ifdef PTXCONF_QT4_EXAMPLES_PUZZLE
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/itemviews/puzzle/puzzle, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/puzzle)
endif

ifdef PTXCONF_QT4_EXAMPLES_SIMPLEDOMMODEL
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/itemviews/simpledommodel/simpledommodel, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/simpledommodel)
endif

ifdef PTXCONF_QT4_EXAMPLES_SIMPLETREEMODEL
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/itemviews/simpletreemodel/simpletreemodel, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/simpletreemodel)
endif

ifdef PTXCONF_QT4_EXAMPLES_SIMPLEWIDGETMAPPER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/itemviews/simplewidgetmapper/simplewidgetmapper, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/simplewidgetmapper)
endif

ifdef PTXCONF_QT4_EXAMPLES_SPINBOXDELEGATE
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/itemviews/spinboxdelegate/spinboxdelegate, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/spinboxdelegate)
endif

ifdef PTXCONF_QT4_EXAMPLES_STARDELEGATE
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/itemviews/stardelegate/stardelegate, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/stardelegate)
endif

ifdef PTXCONF_QT4_EXAMPLES_BASICLAYOUTS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/layouts/basiclayouts/basiclayouts, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/basiclayouts)
endif

ifdef PTXCONF_QT4_EXAMPLES_BORDERLAYOUT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/layouts/borderlayout/borderlayout, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/borderlayout)
endif

ifdef PTXCONF_QT4_EXAMPLES_DYNAMICLAYOUTS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/layouts/dynamiclayouts/dynamiclayouts, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/dynamiclayouts)
endif

ifdef PTXCONF_QT4_EXAMPLES_FLOWLAYOUT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/layouts/flowlayout/flowlayout, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/flowlayout)
endif

ifdef PTXCONF_QT4_EXAMPLES_ARROWPAD
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/linguist/arrowpad/arrowpad, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/arrowpad)
endif

ifdef PTXCONF_QT4_EXAMPLES_HELLOTR
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/linguist/hellotr/hellotr, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/hellotr)
endif

ifdef PTXCONF_QT4_EXAMPLES_TROLLPRINT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/linguist/trollprint/trollprint, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/trollprint)
endif

ifdef PTXCONF_QT4_EXAMPLES_APPLICATION
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/mainwindows/application/application, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/application)
endif

ifdef PTXCONF_QT4_EXAMPLES_DOCKWIDGETS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/mainwindows/dockwidgets/dockwidgets, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/dockwidgets)
endif

ifdef PTXCONF_QT4_EXAMPLES_MDI
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/mainwindows/mdi/mdi, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/mdi)
endif

ifdef PTXCONF_QT4_EXAMPLES_MENUS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/mainwindows/menus/menus, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/menus)
endif

ifdef PTXCONF_QT4_EXAMPLES_RECENTFILES
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/mainwindows/recentfiles/recentfiles, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/recentfiles)
endif

ifdef PTXCONF_QT4_EXAMPLES_SDI
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/mainwindows/sdi/sdi, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/sdi)
endif

ifdef PTXCONF_QT4_EXAMPLES_BLOCKINGFORTUNECLIENT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/network/blockingfortuneclient/blockingfortuneclient, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/blockingfortuneclient)
endif

ifdef PTXCONF_QT4_EXAMPLES_BROADCASTRECEIVER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/network/broadcastreceiver/broadcastreceiver, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/broadcastreceiver)
endif

ifdef PTXCONF_QT4_EXAMPLES_BROADCASTSENDER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/network/broadcastsender/broadcastsender, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/broadcastsender)
endif

ifdef PTXCONF_QT4_EXAMPLES_DOWNLOAD
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/network/download/download, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/download)
endif

ifdef PTXCONF_QT4_EXAMPLES_DOWNLOADMANAGER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/network/downloadmanager/downloadmanager, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/downloadmanager)
endif

ifdef PTXCONF_QT4_EXAMPLES_FORTUNECLIENT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/network/fortuneclient/fortuneclient, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/fortuneclient)
endif

ifdef PTXCONF_QT4_EXAMPLES_FORTUNESERVER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/network/fortuneserver/fortuneserver, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/fortuneserver)
endif

ifdef PTXCONF_QT4_EXAMPLES_FTP
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/network/ftp/ftp, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/ftp)
endif

ifdef PTXCONF_QT4_EXAMPLES_GOOGLESUGGEST
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/network/googlesuggest/googlesuggest, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/googlesuggest)
endif

ifdef PTXCONF_QT4_EXAMPLES_HTTP
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/network/http/http, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/http)
endif

ifdef PTXCONF_QT4_EXAMPLES_LOOPBACK
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/network/loopback/loopback, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/loopback)
endif

ifdef PTXCONF_QT4_EXAMPLES_NETWORK_CHAT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/network/network-chat/network-chat, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/network-chat)
endif

ifdef PTXCONF_QT4_EXAMPLES_THREADEDFORTUNESERVER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/network/threadedfortuneserver/threadedfortuneserver, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/threadedfortuneserver)
endif

ifdef PTXCONF_QT4_EXAMPLES_TORRENT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/network/torrent/torrent, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/torrent)
endif

ifdef PTXCONF_QT4_EXAMPLES_2DPAINTING
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/opengl/2dpainting/2dpainting, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/2dpainting)
endif

ifdef PTXCONF_QT4_EXAMPLES_FRAMEBUFFEROBJECT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/opengl/framebufferobject/framebufferobject, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/framebufferobject)
endif

ifdef PTXCONF_QT4_EXAMPLES_FRAMEBUFFEROBJECT2
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/opengl/framebufferobject2/framebufferobject2, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/framebufferobject2)
endif

ifdef PTXCONF_QT4_EXAMPLES_GRABBER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/opengl/grabber/grabber, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/grabber)
endif

ifdef PTXCONF_QT4_EXAMPLES_HELLOGL
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/opengl/hellogl/hellogl, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/hellogl)
endif

ifdef PTXCONF_QT4_EXAMPLES_OVERPAINTING
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/opengl/overpainting/overpainting, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/overpainting)
endif

ifdef PTXCONF_QT4_EXAMPLES_PBUFFERS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/opengl/pbuffers/pbuffers, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/pbuffers)
endif

ifdef PTXCONF_QT4_EXAMPLES_PBUFFERS2
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/opengl/pbuffers2/pbuffers2, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/pbuffers2)
endif

ifdef PTXCONF_QT4_EXAMPLES_SAMPLEBUFFERS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/opengl/samplebuffers/samplebuffers, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/samplebuffers)
endif

ifdef PTXCONF_QT4_EXAMPLES_TEXTURES
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/opengl/textures/textures, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/textures)
endif

ifdef PTXCONF_QT4_EXAMPLES_BASICDRAWING
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/painting/basicdrawing/basicdrawing, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/basicdrawing)
endif

ifdef PTXCONF_QT4_EXAMPLES_CONCENTRICCIRCLES
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/painting/concentriccircles/concentriccircles, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/concentriccircles)
endif

ifdef PTXCONF_QT4_EXAMPLES_FONTSAMPLER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/painting/fontsampler/fontsampler, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/fontsampler)
endif

ifdef PTXCONF_QT4_EXAMPLES_IMAGECOMPOSITION
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/painting/imagecomposition/imagecomposition, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/imagecomposition)
endif

ifdef PTXCONF_QT4_EXAMPLES_PAINTERPATHS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/painting/painterpaths/painterpaths, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/painterpaths)
endif

ifdef PTXCONF_QT4_EXAMPLES_SVGGENERATOR
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/painting/svggenerator/svggenerator, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/svggenerator)
endif

ifdef PTXCONF_QT4_EXAMPLES_SVGVIEWER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/painting/svgviewer/svgviewer, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/svgviewer)
endif

ifdef PTXCONF_QT4_EXAMPLES_TRANSFORMATIONS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/painting/transformations/transformations, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/transformations)
endif

ifdef PTXCONF_QT4_EXAMPLES_CAPABILITIES
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/phonon/capabilities/capabilities, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/capabilities)
endif

ifdef PTXCONF_QT4_EXAMPLES_MUSICPLAYER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/phonon/musicplayer/musicplayer, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/musicplayer)
endif

ifdef PTXCONF_QT4_EXAMPLES_IMAGESCALING
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/qtconcurrent/imagescaling/imagescaling, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/imagescaling)
endif

ifdef PTXCONF_QT4_EXAMPLES_MAPDEMO
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/qtconcurrent/map/mapdemo, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/mapdemo)
endif

ifdef PTXCONF_QT4_EXAMPLES_PROGRESSDIALOG
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/qtconcurrent/progressdialog/progressdialog, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/progressdialog)
endif

ifdef PTXCONF_QT4_EXAMPLES_RUNFUNCTION
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/qtconcurrent/runfunction/runfunction, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/runfunction)
endif

ifdef PTXCONF_QT4_EXAMPLES_WORDCOUNT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/qtconcurrent/wordcount/wordcount, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/wordcount)
endif

ifdef PTXCONF_QT4_EXAMPLES_TUTORIAL1
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/qtestlib/tutorial1/tutorial1, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tutorial1)
endif

ifdef PTXCONF_QT4_EXAMPLES_TUTORIAL2
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/qtestlib/tutorial2/tutorial2, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tutorial2)
endif

ifdef PTXCONF_QT4_EXAMPLES_TUTORIAL3
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/qtestlib/tutorial3/tutorial3, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tutorial3)
endif

ifdef PTXCONF_QT4_EXAMPLES_TUTORIAL4
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/qtestlib/tutorial4/tutorial4, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tutorial4)
endif

ifdef PTXCONF_QT4_EXAMPLES_TUTORIAL5
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/qtestlib/tutorial5/tutorial5, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tutorial5)
endif

ifdef PTXCONF_QT4_EXAMPLES_FRAMEBUFFER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/qws/framebuffer/framebuffer, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/framebuffer)
endif

ifdef PTXCONF_QT4_EXAMPLES_MOUSECALIBRATION
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/qws/mousecalibration/mousecalibration, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/mousecalibration)
endif

ifdef PTXCONF_QT4_EXAMPLES_SIMPLEDECORATION
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/qws/simpledecoration/simpledecoration, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/simpledecoration)
endif

ifdef PTXCONF_QT4_EXAMPLES_CALENDAR
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/richtext/calendar/calendar, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/calendar)
endif

ifdef PTXCONF_QT4_EXAMPLES_ORDERFORM
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/richtext/orderform/orderform, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/orderform)
endif

ifdef PTXCONF_QT4_EXAMPLES_SYNTAXHIGHLIGHTER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/richtext/syntaxhighlighter/syntaxhighlighter, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/syntaxhighlighter)
endif

ifdef PTXCONF_QT4_EXAMPLES_TEXTOBJECT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/richtext/textobject/textobject, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/textobject)
endif

ifdef PTXCONF_QT4_EXAMPLES_CONTEXT2D
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/script/context2d/context2d, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/context2d)
endif

ifdef PTXCONF_QT4_EXAMPLES_CUSTOMCLASS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/script/customclass/customclass, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/customclass)
endif

ifdef PTXCONF_QT4_EXAMPLES_DEFAULTPROTOTYPES
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/script/defaultprototypes/defaultprototypes, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/defaultprototypes)
endif

ifdef PTXCONF_QT4_EXAMPLES_HELLOSCRIPT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/script/helloscript/helloscript, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/helloscript)
endif

ifdef PTXCONF_QT4_EXAMPLES_MARSHAL
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/script/marshal/marshal, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/marshal)
endif

ifdef PTXCONF_QT4_EXAMPLES_QSCRIPT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/script/qscript/qscript, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/qscript)
endif

ifdef PTXCONF_QT4_EXAMPLES_CACHEDTABLE
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/sql/cachedtable/cachedtable, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/cachedtable)
endif

ifdef PTXCONF_QT4_EXAMPLES_DRILLDOWN
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/sql/drilldown/drilldown, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/drilldown)
endif

ifdef PTXCONF_QT4_EXAMPLES_MASTERDETAIL
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/sql/masterdetail/masterdetail, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/masterdetail)
endif

ifdef PTXCONF_QT4_EXAMPLES_QUERYMODEL
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/sql/querymodel/querymodel, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/querymodel)
endif

ifdef PTXCONF_QT4_EXAMPLES_RELATIONALTABLEMODEL
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/sql/relationaltablemodel/relationaltablemodel, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/relationaltablemodel)
endif

ifdef PTXCONF_QT4_EXAMPLES_SQLWIDGETMAPPER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/sql/sqlwidgetmapper/sqlwidgetmapper, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/sqlwidgetmapper)
endif

ifdef PTXCONF_QT4_EXAMPLES_TABLEMODEL
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/sql/tablemodel/tablemodel, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tablemodel)
endif

ifdef PTXCONF_QT4_EXAMPLES_MANDELBROT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/threads/mandelbrot/mandelbrot, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/mandelbrot)
endif

ifdef PTXCONF_QT4_EXAMPLES_SEMAPHORES
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/threads/semaphores/semaphores, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/semaphores)
endif

ifdef PTXCONF_QT4_EXAMPLES_WAITCONDITIONS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/threads/waitconditions/waitconditions, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/waitconditions)
endif

ifdef PTXCONF_QT4_EXAMPLES_CODECS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/tools/codecs/codecs, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/codecs)
endif

ifdef PTXCONF_QT4_EXAMPLES_COMPLETER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/tools/completer/completer, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/completer)
endif

ifdef PTXCONF_QT4_EXAMPLES_CUSTOMCOMPLETER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/tools/customcompleter/customcompleter, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/customcompleter)
endif

ifdef PTXCONF_QT4_EXAMPLES_ECHOPLUGIN
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/tools/echoplugin/echowindow/../echoplugin, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/echoplugin)
endif

ifdef PTXCONF_QT4_EXAMPLES_I18N
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/tools/i18n/i18n, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/i18n)
endif

ifdef PTXCONF_QT4_EXAMPLES_PLUGANDPAINT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/tools/plugandpaint/plugandpaint, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/plugandpaint)
endif

ifdef PTXCONF_QT4_EXAMPLES_REGEXP
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/tools/regexp/regexp, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/regexp)
endif

ifdef PTXCONF_QT4_EXAMPLES_SETTINGSEDITOR
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/tools/settingseditor/settingseditor, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/settingseditor)
endif

ifdef PTXCONF_QT4_EXAMPLES_STYLEPLUGIN
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/tools/styleplugin/stylewindow/../styleplugin, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/styleplugin)
endif

ifdef PTXCONF_QT4_EXAMPLES_TREEMODELCOMPLETER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/tools/treemodelcompleter/treemodelcompleter, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/treemodelcompleter)
endif

ifdef PTXCONF_QT4_EXAMPLES_UNDOFRAMEWORK
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/tools/undoframework/undoframework, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/undoframework)
endif

ifdef PTXCONF_QT4_EXAMPLES_PART1
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/tutorials/addressbook/part1/part1, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/part1)
endif

ifdef PTXCONF_QT4_EXAMPLES_PART2
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/tutorials/addressbook/part2/part2, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/part2)
endif

ifdef PTXCONF_QT4_EXAMPLES_PART3
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/tutorials/addressbook/part3/part3, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/part3)
endif

ifdef PTXCONF_QT4_EXAMPLES_PART4
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/tutorials/addressbook/part4/part4, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/part4)
endif

ifdef PTXCONF_QT4_EXAMPLES_PART5
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/tutorials/addressbook/part5/part5, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/part5)
endif

ifdef PTXCONF_QT4_EXAMPLES_PART6
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/tutorials/addressbook/part6/part6, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/part6)
endif

ifdef PTXCONF_QT4_EXAMPLES_PART7
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/tutorials/addressbook/part7/part7, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/part7)
endif

ifdef PTXCONF_QT4_EXAMPLES_MULTIPLEINHERITANCE
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/uitools/multipleinheritance/multipleinheritance, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/multipleinheritance)
endif

ifdef PTXCONF_QT4_EXAMPLES_TEXTFINDER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/uitools/textfinder/textfinder, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/textfinder)
endif

ifdef PTXCONF_QT4_EXAMPLES_FANCYBROWSER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/webkit/fancybrowser/fancybrowser, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/fancybrowser)
endif

ifdef PTXCONF_QT4_EXAMPLES_FORMEXTRACTOR
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/webkit/formextractor/formextractor, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/formextractor)
endif

ifdef PTXCONF_QT4_EXAMPLES_GOOGLECHAT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/webkit/googlechat/googlechat, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/googlechat)
endif

ifdef PTXCONF_QT4_EXAMPLES_PREVIEWER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/webkit/previewer/previewer, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/previewer)
endif

ifdef PTXCONF_QT4_EXAMPLES_ANALOGCLOCK
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/widgets/analogclock/analogclock, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/analogclock)
endif

ifdef PTXCONF_QT4_EXAMPLES_CALCULATOR
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/widgets/calculator/calculator, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/calculator)
endif

ifdef PTXCONF_QT4_EXAMPLES_CALENDARWIDGET
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/widgets/calendarwidget/calendarwidget, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/calendarwidget)
endif

ifdef PTXCONF_QT4_EXAMPLES_CHARACTERMAP
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/widgets/charactermap/charactermap, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/charactermap)
endif

ifdef PTXCONF_QT4_EXAMPLES_CODEEDITOR
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/widgets/codeeditor/codeeditor, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/codeeditor)
endif

ifdef PTXCONF_QT4_EXAMPLES_DIGITALCLOCK
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/widgets/digitalclock/digitalclock, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/digitalclock)
endif

ifdef PTXCONF_QT4_EXAMPLES_GROUPBOX
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/widgets/groupbox/groupbox, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/groupbox)
endif

ifdef PTXCONF_QT4_EXAMPLES_ICONS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/widgets/icons/icons, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/icons)
endif

ifdef PTXCONF_QT4_EXAMPLES_IMAGEVIEWER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/widgets/imageviewer/imageviewer, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/imageviewer)
endif

ifdef PTXCONF_QT4_EXAMPLES_LINEEDITS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/widgets/lineedits/lineedits, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/lineedits)
endif

ifdef PTXCONF_QT4_EXAMPLES_MOVIE
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/widgets/movie/movie, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/movie)
endif

ifdef PTXCONF_QT4_EXAMPLES_SCRIBBLE
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/widgets/scribble/scribble, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/scribble)
endif

ifdef PTXCONF_QT4_EXAMPLES_SHAPEDCLOCK
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/widgets/shapedclock/shapedclock, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/shapedclock)
endif

ifdef PTXCONF_QT4_EXAMPLES_SLIDERS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/widgets/sliders/sliders, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/sliders)
endif

ifdef PTXCONF_QT4_EXAMPLES_SPINBOXES
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/widgets/spinboxes/spinboxes, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/spinboxes)
endif

ifdef PTXCONF_QT4_EXAMPLES_STYLES
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/widgets/styles/styles, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/styles)
endif

ifdef PTXCONF_QT4_EXAMPLES_STYLESHEET
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/widgets/stylesheet/stylesheet, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/stylesheet)
endif

ifdef PTXCONF_QT4_EXAMPLES_TABLET
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/widgets/tablet/tablet, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tablet)
endif

ifdef PTXCONF_QT4_EXAMPLES_TETRIX
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/widgets/tetrix/tetrix, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tetrix)
endif

ifdef PTXCONF_QT4_EXAMPLES_TOOLTIPS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/widgets/tooltips/tooltips, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tooltips)
endif

ifdef PTXCONF_QT4_EXAMPLES_VALIDATORS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/widgets/validators/validators, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/validators)
endif

ifdef PTXCONF_QT4_EXAMPLES_WIGGLY
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/widgets/wiggly/wiggly, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/wiggly)
endif

ifdef PTXCONF_QT4_EXAMPLES_WINDOWFLAGS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/widgets/windowflags/windowflags, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/windowflags)
endif

ifdef PTXCONF_QT4_EXAMPLES_DOMBOOKMARKS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/xml/dombookmarks/dombookmarks, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/dombookmarks)
endif

ifdef PTXCONF_QT4_EXAMPLES_RSSLISTING
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/xml/rsslisting/rsslisting, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/rsslisting)
endif

ifdef PTXCONF_QT4_EXAMPLES_SAXBOOKMARKS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/xml/saxbookmarks/saxbookmarks, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/saxbookmarks)
endif

ifdef PTXCONF_QT4_EXAMPLES_STREAMBOOKMARKS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/xml/streambookmarks/streambookmarks, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/streambookmarks)
endif

ifdef PTXCONF_QT4_EXAMPLES_XMLSTREAMLINT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/xml/xmlstreamlint/xmlstreamlint, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/xmlstreamlint)
endif

ifdef PTXCONF_QT4_EXAMPLES_FILETREE
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/xmlpatterns/filetree/filetree, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/filetree)
endif

ifdef PTXCONF_QT4_EXAMPLES_QOBJECTXMLMODEL
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/xmlpatterns/qobjectxmlmodel/qobjectxmlmodel, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/qobjectxmlmodel)
endif

ifdef PTXCONF_QT4_EXAMPLES_RECIPES
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/xmlpatterns/recipes/recipes, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/recipes)
endif

ifdef PTXCONF_QT4_EXAMPLES_TRAFFICINFO
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)/examples/xmlpatterns/trafficinfo/trafficinfo, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/trafficinfo)
endif


	@$(call install_finish,qt4-examples)
	@$(call touch, $@)

