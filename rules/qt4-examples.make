# WARNING: this file is generated with qt4_mk_examples.sh
# do not edit

PTX_MAP_TO_PACKAGE_qt4-examples := QT4

ifdef PTXCONF_QT4_EXAMPLES
$(STATEDIR)/qt4.targetinstall.post: $(STATEDIR)/qt4-examples.targetinstall
endif

$(STATEDIR)/qt4-examples.targetinstall: $(STATEDIR)/qt4.targetinstall
	@$(call targetinfo, $@)
	@$(call install_init, qt4-examples)
	@$(call install_fixup, qt4-examples,PACKAGE,qt4-examples)
	@$(call install_fixup, qt4-examples,PRIORITY,optional)
	@$(call install_fixup, qt4-examples,VERSION,$(QT4_VERSION))
	@$(call install_fixup, qt4-examples,SECTION,base)
	@$(call install_fixup, qt4-examples,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, qt4-examples,DEPENDS,)
	@$(call install_fixup, qt4-examples,DESCRIPTION,missing)

ifdef PTXCONF_QT4_EXAMPLES_ANIMATION_ANIMATEDTILES
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/animation/animatedtiles/animatedtiles, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/animation/animatedtiles/animatedtiles)
endif

ifdef PTXCONF_QT4_EXAMPLES_ANIMATION_APPCHOOSER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/animation/appchooser/appchooser, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/animation/appchooser/appchooser)
endif

ifdef PTXCONF_QT4_EXAMPLES_ANIMATION_EASING
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/animation/easing/easing, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/animation/easing/easing)
endif

ifdef PTXCONF_QT4_EXAMPLES_ANIMATION_MOVEBLOCKS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/animation/moveblocks/moveblocks, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/animation/moveblocks/moveblocks)
endif

ifdef PTXCONF_QT4_EXAMPLES_ANIMATION_STATES
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/animation/states/states, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/animation/states/states)
endif

ifdef PTXCONF_QT4_EXAMPLES_ANIMATION_STICKMAN
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/animation/stickman/stickman, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/animation/stickman/stickman)
endif

ifdef PTXCONF_QT4_EXAMPLES_ASSISTANT_SIMPLETEXTVIEWER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/assistant/simpletextviewer/simpletextviewer, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/assistant/simpletextviewer/simpletextviewer)
endif

ifdef PTXCONF_QT4_EXAMPLES_DBUS_COMPLEXPING
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/dbus/complexpingpong/complexpong, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/dbus/complexpingpong/complexpong)
endif

ifdef PTXCONF_QT4_EXAMPLES_DBUS_COMPLEXPONG
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/dbus/complexpingpong/complexpong, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/dbus/complexpingpong/complexpong)
endif

ifdef PTXCONF_QT4_EXAMPLES_DBUS_DBUS_CHAT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/dbus/dbus-chat/dbus-chat, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/dbus/dbus-chat/dbus-chat)
endif

ifdef PTXCONF_QT4_EXAMPLES_DBUS_LISTNAMES
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/dbus/listnames/listnames, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/dbus/listnames/listnames)
endif

ifdef PTXCONF_QT4_EXAMPLES_DBUS_PING
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/dbus/pingpong/pong, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/dbus/pingpong/pong)
endif

ifdef PTXCONF_QT4_EXAMPLES_DBUS_PONG
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/dbus/pingpong/pong, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/dbus/pingpong/pong)
endif

ifdef PTXCONF_QT4_EXAMPLES_DBUS_CAR
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/dbus/remotecontrolledcar/car/car, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/dbus/remotecontrolledcar/car/car)
endif

ifdef PTXCONF_QT4_EXAMPLES_DBUS_CONTROLLER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/dbus/remotecontrolledcar/controller/controller, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/dbus/remotecontrolledcar/controller/controller)
endif

ifdef PTXCONF_QT4_EXAMPLES_DESIGNER_CALCULATORBUILDER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/designer/calculatorbuilder/calculatorbuilder, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/designer/calculatorbuilder/calculatorbuilder)
endif

ifdef PTXCONF_QT4_EXAMPLES_DESIGNER_CALCULATORFORM
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/designer/calculatorform/calculatorform, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/designer/calculatorform/calculatorform)
endif

ifdef PTXCONF_QT4_EXAMPLES_DESIGNER_WORLDTIMECLOCKBUILDER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/designer/worldtimeclockbuilder/worldtimeclockbuilder, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/designer/worldtimeclockbuilder/worldtimeclockbuilder)
endif

ifdef PTXCONF_QT4_EXAMPLES_DESKTOP_SCREENSHOT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/desktop/screenshot/screenshot, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/desktop/screenshot/screenshot)
endif

ifdef PTXCONF_QT4_EXAMPLES_DESKTOP_SYSTRAY
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/desktop/systray/systray, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/desktop/systray/systray)
endif

ifdef PTXCONF_QT4_EXAMPLES_DIALOGS_CLASSWIZARD
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/dialogs/classwizard/classwizard, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/dialogs/classwizard/classwizard)
endif

ifdef PTXCONF_QT4_EXAMPLES_DIALOGS_CONFIGDIALOG
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/dialogs/configdialog/configdialog, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/dialogs/configdialog/configdialog)
endif

ifdef PTXCONF_QT4_EXAMPLES_DIALOGS_EXTENSION
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/dialogs/extension/extension, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/dialogs/extension/extension)
endif

ifdef PTXCONF_QT4_EXAMPLES_DIALOGS_FINDFILES
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/dialogs/findfiles/findfiles, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/dialogs/findfiles/findfiles)
endif

ifdef PTXCONF_QT4_EXAMPLES_DIALOGS_LICENSEWIZARD
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/dialogs/licensewizard/licensewizard, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/dialogs/licensewizard/licensewizard)
endif

ifdef PTXCONF_QT4_EXAMPLES_DIALOGS_STANDARDDIALOGS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/dialogs/standarddialogs/standarddialogs, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/dialogs/standarddialogs/standarddialogs)
endif

ifdef PTXCONF_QT4_EXAMPLES_DIALOGS_TABDIALOG
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/dialogs/tabdialog/tabdialog, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/dialogs/tabdialog/tabdialog)
endif

ifdef PTXCONF_QT4_EXAMPLES_DIALOGS_TRIVIALWIZARD
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/dialogs/trivialwizard/trivialwizard, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/dialogs/trivialwizard/trivialwizard)
endif

ifdef PTXCONF_QT4_EXAMPLES_DRAGANDDROP_DELAYEDENCODING
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/draganddrop/delayedencoding/delayedencoding, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/draganddrop/delayedencoding/delayedencoding)
endif

ifdef PTXCONF_QT4_EXAMPLES_DRAGANDDROP_DRAGGABLEICONS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/draganddrop/draggableicons/draggableicons, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/draganddrop/draggableicons/draggableicons)
endif

ifdef PTXCONF_QT4_EXAMPLES_DRAGANDDROP_DRAGGABLETEXT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/draganddrop/draggabletext/draggabletext, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/draganddrop/draggabletext/draggabletext)
endif

ifdef PTXCONF_QT4_EXAMPLES_DRAGANDDROP_DROPSITE
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/draganddrop/dropsite/dropsite, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/draganddrop/dropsite/dropsite)
endif

ifdef PTXCONF_QT4_EXAMPLES_DRAGANDDROP_FRIDGEMAGNETS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/draganddrop/fridgemagnets/fridgemagnets, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/draganddrop/fridgemagnets/fridgemagnets)
endif

ifdef PTXCONF_QT4_EXAMPLES_DRAGANDDROP_PUZZLE
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/draganddrop/puzzle/puzzle, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/draganddrop/puzzle/puzzle)
endif

ifdef PTXCONF_QT4_EXAMPLES_EFFECTS_BLURPICKER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/effects/blurpicker/blurpicker, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/effects/blurpicker/blurpicker)
endif

ifdef PTXCONF_QT4_EXAMPLES_EFFECTS_FADEMESSAGE
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/effects/fademessage/fademessage, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/effects/fademessage/fademessage)
endif

ifdef PTXCONF_QT4_EXAMPLES_EFFECTS_LIGHTING
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/effects/lighting/lighting, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/effects/lighting/lighting)
endif

ifdef PTXCONF_QT4_EXAMPLES_GESTURES_IMAGEGESTURES
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/gestures/imagegestures/imagegestures, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/gestures/imagegestures/imagegestures)
endif

ifdef PTXCONF_QT4_EXAMPLES_GRAPHICSVIEW_ANCHORLAYOUT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/graphicsview/anchorlayout/anchorlayout, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/graphicsview/anchorlayout/anchorlayout)
endif

ifdef PTXCONF_QT4_EXAMPLES_GRAPHICSVIEW_BASICGRAPHICSLAYOUTS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/graphicsview/basicgraphicslayouts/basicgraphicslayouts, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/graphicsview/basicgraphicslayouts/basicgraphicslayouts)
endif

ifdef PTXCONF_QT4_EXAMPLES_GRAPHICSVIEW_COLLIDINGMICE
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/graphicsview/collidingmice/collidingmice, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/graphicsview/collidingmice/collidingmice)
endif

ifdef PTXCONF_QT4_EXAMPLES_GRAPHICSVIEW_DIAGRAMSCENE
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/graphicsview/diagramscene/diagramscene, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/graphicsview/diagramscene/diagramscene)
endif

ifdef PTXCONF_QT4_EXAMPLES_GRAPHICSVIEW_DRAGDROPROBOT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/graphicsview/dragdroprobot/dragdroprobot, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/graphicsview/dragdroprobot/dragdroprobot)
endif

ifdef PTXCONF_QT4_EXAMPLES_GRAPHICSVIEW_ELASTICNODES
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/graphicsview/elasticnodes/elasticnodes, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/graphicsview/elasticnodes/elasticnodes)
endif

ifdef PTXCONF_QT4_EXAMPLES_GRAPHICSVIEW_FLOWLAYOUT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/graphicsview/flowlayout/flowlayout, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/graphicsview/flowlayout/flowlayout)
endif

ifdef PTXCONF_QT4_EXAMPLES_GRAPHICSVIEW_PADNAVIGATOR
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/graphicsview/padnavigator/padnavigator, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/graphicsview/padnavigator/padnavigator)
endif

ifdef PTXCONF_QT4_EXAMPLES_GRAPHICSVIEW_WEATHERANCHORLAYOUT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/graphicsview/weatheranchorlayout/weatheranchorlayout, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/graphicsview/weatheranchorlayout/weatheranchorlayout)
endif

ifdef PTXCONF_QT4_EXAMPLES_HELP_CONTEXTSENSITIVEHELP
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/help/contextsensitivehelp/contextsensitivehelp, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/help/contextsensitivehelp/contextsensitivehelp)
endif

ifdef PTXCONF_QT4_EXAMPLES_HELP_REMOTECONTROL
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/help/remotecontrol/remotecontrol, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/help/remotecontrol/remotecontrol)
endif

ifdef PTXCONF_QT4_EXAMPLES_HELP_SIMPLETEXTVIEWER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/help/simpletextviewer/simpletextviewer, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/help/simpletextviewer/simpletextviewer)
endif

ifdef PTXCONF_QT4_EXAMPLES_IPC_LOCALFORTUNECLIENT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/ipc/localfortuneclient/localfortuneclient, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/ipc/localfortuneclient/localfortuneclient)
endif

ifdef PTXCONF_QT4_EXAMPLES_IPC_LOCALFORTUNESERVER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/ipc/localfortuneserver/localfortuneserver, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/ipc/localfortuneserver/localfortuneserver)
endif

ifdef PTXCONF_QT4_EXAMPLES_IPC_SHAREDMEMORY
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/ipc/sharedmemory/sharedmemory, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/ipc/sharedmemory/sharedmemory)
endif

ifdef PTXCONF_QT4_EXAMPLES_ITEMVIEWS_ADDRESSBOOK
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/itemviews/addressbook/addressbook, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/itemviews/addressbook/addressbook)
endif

ifdef PTXCONF_QT4_EXAMPLES_ITEMVIEWS_BASICSORTFILTERMODEL
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/itemviews/basicsortfiltermodel/basicsortfiltermodel, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/itemviews/basicsortfiltermodel/basicsortfiltermodel)
endif

ifdef PTXCONF_QT4_EXAMPLES_ITEMVIEWS_CHART
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/itemviews/chart/chart, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/itemviews/chart/chart)
endif

ifdef PTXCONF_QT4_EXAMPLES_ITEMVIEWS_COLOREDITORFACTORY
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/itemviews/coloreditorfactory/coloreditorfactory, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/itemviews/coloreditorfactory/coloreditorfactory)
endif

ifdef PTXCONF_QT4_EXAMPLES_ITEMVIEWS_COMBOWIDGETMAPPER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/itemviews/combowidgetmapper/combowidgetmapper, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/itemviews/combowidgetmapper/combowidgetmapper)
endif

ifdef PTXCONF_QT4_EXAMPLES_ITEMVIEWS_CUSTOMSORTFILTERMODEL
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/itemviews/customsortfiltermodel/customsortfiltermodel, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/itemviews/customsortfiltermodel/customsortfiltermodel)
endif

ifdef PTXCONF_QT4_EXAMPLES_ITEMVIEWS_DIRVIEW
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/itemviews/dirview/dirview, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/itemviews/dirview/dirview)
endif

ifdef PTXCONF_QT4_EXAMPLES_ITEMVIEWS_EDITABLETREEMODEL
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/itemviews/editabletreemodel/editabletreemodel, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/itemviews/editabletreemodel/editabletreemodel)
endif

ifdef PTXCONF_QT4_EXAMPLES_ITEMVIEWS_FETCHMORE
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/itemviews/fetchmore/fetchmore, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/itemviews/fetchmore/fetchmore)
endif

ifdef PTXCONF_QT4_EXAMPLES_ITEMVIEWS_FROZENCOLUMN
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/itemviews/frozencolumn/frozencolumn, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/itemviews/frozencolumn/frozencolumn)
endif

ifdef PTXCONF_QT4_EXAMPLES_ITEMVIEWS_PIXELATOR
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/itemviews/pixelator/pixelator, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/itemviews/pixelator/pixelator)
endif

ifdef PTXCONF_QT4_EXAMPLES_ITEMVIEWS_PUZZLE
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/itemviews/puzzle/puzzle, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/itemviews/puzzle/puzzle)
endif

ifdef PTXCONF_QT4_EXAMPLES_ITEMVIEWS_SIMPLEDOMMODEL
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/itemviews/simpledommodel/simpledommodel, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/itemviews/simpledommodel/simpledommodel)
endif

ifdef PTXCONF_QT4_EXAMPLES_ITEMVIEWS_SIMPLETREEMODEL
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/itemviews/simpletreemodel/simpletreemodel, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/itemviews/simpletreemodel/simpletreemodel)
endif

ifdef PTXCONF_QT4_EXAMPLES_ITEMVIEWS_SIMPLEWIDGETMAPPER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/itemviews/simplewidgetmapper/simplewidgetmapper, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/itemviews/simplewidgetmapper/simplewidgetmapper)
endif

ifdef PTXCONF_QT4_EXAMPLES_ITEMVIEWS_SPINBOXDELEGATE
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/itemviews/spinboxdelegate/spinboxdelegate, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/itemviews/spinboxdelegate/spinboxdelegate)
endif

ifdef PTXCONF_QT4_EXAMPLES_ITEMVIEWS_STARDELEGATE
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/itemviews/stardelegate/stardelegate, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/itemviews/stardelegate/stardelegate)
endif

ifdef PTXCONF_QT4_EXAMPLES_LAYOUTS_BASICLAYOUTS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/layouts/basiclayouts/basiclayouts, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/layouts/basiclayouts/basiclayouts)
endif

ifdef PTXCONF_QT4_EXAMPLES_LAYOUTS_BORDERLAYOUT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/layouts/borderlayout/borderlayout, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/layouts/borderlayout/borderlayout)
endif

ifdef PTXCONF_QT4_EXAMPLES_LAYOUTS_DYNAMICLAYOUTS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/layouts/dynamiclayouts/dynamiclayouts, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/layouts/dynamiclayouts/dynamiclayouts)
endif

ifdef PTXCONF_QT4_EXAMPLES_LAYOUTS_FLOWLAYOUT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/layouts/flowlayout/flowlayout, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/layouts/flowlayout/flowlayout)
endif

ifdef PTXCONF_QT4_EXAMPLES_LINGUIST_ARROWPAD
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/linguist/arrowpad/arrowpad, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/linguist/arrowpad/arrowpad)
endif

ifdef PTXCONF_QT4_EXAMPLES_LINGUIST_HELLOTR
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/linguist/hellotr/hellotr, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/linguist/hellotr/hellotr)
endif

ifdef PTXCONF_QT4_EXAMPLES_LINGUIST_TROLLPRINT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/linguist/trollprint/trollprint, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/linguist/trollprint/trollprint)
endif

ifdef PTXCONF_QT4_EXAMPLES_MAINWINDOWS_APPLICATION
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/mainwindows/application/application, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/mainwindows/application/application)
endif

ifdef PTXCONF_QT4_EXAMPLES_MAINWINDOWS_DOCKWIDGETS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/mainwindows/dockwidgets/dockwidgets, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/mainwindows/dockwidgets/dockwidgets)
endif

ifdef PTXCONF_QT4_EXAMPLES_MAINWINDOWS_MDI
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/mainwindows/mdi/mdi, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/mainwindows/mdi/mdi)
endif

ifdef PTXCONF_QT4_EXAMPLES_MAINWINDOWS_MENUS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/mainwindows/menus/menus, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/mainwindows/menus/menus)
endif

ifdef PTXCONF_QT4_EXAMPLES_MAINWINDOWS_RECENTFILES
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/mainwindows/recentfiles/recentfiles, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/mainwindows/recentfiles/recentfiles)
endif

ifdef PTXCONF_QT4_EXAMPLES_MAINWINDOWS_SDI
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/mainwindows/sdi/sdi, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/mainwindows/sdi/sdi)
endif

ifdef PTXCONF_QT4_EXAMPLES_MULTIMEDIA_AUDIODEVICES
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/multimedia/audiodevices/audiodevices, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/multimedia/audiodevices/audiodevices)
endif

ifdef PTXCONF_QT4_EXAMPLES_MULTIMEDIA_AUDIOINPUT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/multimedia/audioinput/audioinput, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/multimedia/audioinput/audioinput)
endif

ifdef PTXCONF_QT4_EXAMPLES_MULTIMEDIA_AUDIOOUTPUT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/multimedia/audiooutput/audiooutput, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/multimedia/audiooutput/audiooutput)
endif

ifdef PTXCONF_QT4_EXAMPLES_MULTIMEDIA_VIDEOGRAPHICSITEM
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/multimedia/videographicsitem/videographicsitem, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/multimedia/videographicsitem/videographicsitem)
endif

ifdef PTXCONF_QT4_EXAMPLES_MULTIMEDIA_VIDEOWIDGET
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/multimedia/videowidget/videowidget, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/multimedia/videowidget/videowidget)
endif

ifdef PTXCONF_QT4_EXAMPLES_MULTITOUCH_DIALS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/multitouch/dials/dials, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/multitouch/dials/dials)
endif

ifdef PTXCONF_QT4_EXAMPLES_MULTITOUCH_FINGERPAINT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/multitouch/fingerpaint/fingerpaint, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/multitouch/fingerpaint/fingerpaint)
endif

ifdef PTXCONF_QT4_EXAMPLES_MULTITOUCH_KNOBS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/multitouch/knobs/knobs, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/multitouch/knobs/knobs)
endif

ifdef PTXCONF_QT4_EXAMPLES_MULTITOUCH_PINCHZOOM
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/multitouch/pinchzoom/pinchzoom, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/multitouch/pinchzoom/pinchzoom)
endif

ifdef PTXCONF_QT4_EXAMPLES_NETWORK_BLOCKINGFORTUNECLIENT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/network/blockingfortuneclient/blockingfortuneclient, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/network/blockingfortuneclient/blockingfortuneclient)
endif

ifdef PTXCONF_QT4_EXAMPLES_NETWORK_BROADCASTRECEIVER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/network/broadcastreceiver/broadcastreceiver, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/network/broadcastreceiver/broadcastreceiver)
endif

ifdef PTXCONF_QT4_EXAMPLES_NETWORK_BROADCASTSENDER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/network/broadcastsender/broadcastsender, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/network/broadcastsender/broadcastsender)
endif

ifdef PTXCONF_QT4_EXAMPLES_NETWORK_DOWNLOAD
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/network/download/download, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/network/download/download)
endif

ifdef PTXCONF_QT4_EXAMPLES_NETWORK_DOWNLOADMANAGER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/network/downloadmanager/downloadmanager, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/network/downloadmanager/downloadmanager)
endif

ifdef PTXCONF_QT4_EXAMPLES_NETWORK_FORTUNECLIENT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/network/fortuneclient/fortuneclient, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/network/fortuneclient/fortuneclient)
endif

ifdef PTXCONF_QT4_EXAMPLES_NETWORK_FORTUNESERVER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/network/fortuneserver/fortuneserver, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/network/fortuneserver/fortuneserver)
endif

ifdef PTXCONF_QT4_EXAMPLES_NETWORK_GOOGLESUGGEST
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/network/googlesuggest/googlesuggest, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/network/googlesuggest/googlesuggest)
endif

ifdef PTXCONF_QT4_EXAMPLES_NETWORK_HTTP
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/network/http/http, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/network/http/http)
endif

ifdef PTXCONF_QT4_EXAMPLES_NETWORK_LOOPBACK
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/network/loopback/loopback, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/network/loopback/loopback)
endif

ifdef PTXCONF_QT4_EXAMPLES_NETWORK_NETWORK_CHAT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/network/network-chat/network-chat, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/network/network-chat/network-chat)
endif

ifdef PTXCONF_QT4_EXAMPLES_NETWORK_QFTP
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/network/qftp/qftp, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/network/qftp/qftp)
endif

ifdef PTXCONF_QT4_EXAMPLES_NETWORK_SECURESOCKETCLIENT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/network/securesocketclient/securesocketclient, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/network/securesocketclient/securesocketclient)
endif

ifdef PTXCONF_QT4_EXAMPLES_NETWORK_THREADEDFORTUNESERVER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/network/threadedfortuneserver/threadedfortuneserver, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/network/threadedfortuneserver/threadedfortuneserver)
endif

ifdef PTXCONF_QT4_EXAMPLES_NETWORK_TORRENT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/network/torrent/torrent, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/network/torrent/torrent)
endif

ifdef PTXCONF_QT4_EXAMPLES_OPENGL_2DPAINTING
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/opengl/2dpainting/2dpainting, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/opengl/2dpainting/2dpainting)
endif

ifdef PTXCONF_QT4_EXAMPLES_OPENGL_FRAMEBUFFEROBJECT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/opengl/framebufferobject/framebufferobject, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/opengl/framebufferobject/framebufferobject)
endif

ifdef PTXCONF_QT4_EXAMPLES_OPENGL_FRAMEBUFFEROBJECT2
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/opengl/framebufferobject2/framebufferobject2, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/opengl/framebufferobject2/framebufferobject2)
endif

ifdef PTXCONF_QT4_EXAMPLES_OPENGL_GRABBER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/opengl/grabber/grabber, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/opengl/grabber/grabber)
endif

ifdef PTXCONF_QT4_EXAMPLES_OPENGL_HELLOGL
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/opengl/hellogl/hellogl, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/opengl/hellogl/hellogl)
endif

ifdef PTXCONF_QT4_EXAMPLES_OPENGL_HELLOGL_ES
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/opengl/hellogl_es/hellogl_es, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/opengl/hellogl_es/hellogl_es)
endif

ifdef PTXCONF_QT4_EXAMPLES_OPENGL_HELLOGL_ES2
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/opengl/hellogl_es2/hellogl_es2, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/opengl/hellogl_es2/hellogl_es2)
endif

ifdef PTXCONF_QT4_EXAMPLES_OPENGL_OVERPAINTING
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/opengl/overpainting/overpainting, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/opengl/overpainting/overpainting)
endif

ifdef PTXCONF_QT4_EXAMPLES_OPENGL_PBUFFERS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/opengl/pbuffers/pbuffers, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/opengl/pbuffers/pbuffers)
endif

ifdef PTXCONF_QT4_EXAMPLES_OPENGL_PBUFFERS2
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/opengl/pbuffers2/pbuffers2, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/opengl/pbuffers2/pbuffers2)
endif

ifdef PTXCONF_QT4_EXAMPLES_OPENGL_SAMPLEBUFFERS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/opengl/samplebuffers/samplebuffers, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/opengl/samplebuffers/samplebuffers)
endif

ifdef PTXCONF_QT4_EXAMPLES_OPENGL_TEXTURES
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/opengl/textures/textures, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/opengl/textures/textures)
endif

ifdef PTXCONF_QT4_EXAMPLES_OPENVG_STAR
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/openvg/star/star, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/openvg/star/star)
endif

ifdef PTXCONF_QT4_EXAMPLES_PAINTING_BASICDRAWING
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/painting/basicdrawing/basicdrawing, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/painting/basicdrawing/basicdrawing)
endif

ifdef PTXCONF_QT4_EXAMPLES_PAINTING_CONCENTRICCIRCLES
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/painting/concentriccircles/concentriccircles, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/painting/concentriccircles/concentriccircles)
endif

ifdef PTXCONF_QT4_EXAMPLES_PAINTING_FONTSAMPLER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/painting/fontsampler/fontsampler, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/painting/fontsampler/fontsampler)
endif

ifdef PTXCONF_QT4_EXAMPLES_PAINTING_IMAGECOMPOSITION
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/painting/imagecomposition/imagecomposition, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/painting/imagecomposition/imagecomposition)
endif

ifdef PTXCONF_QT4_EXAMPLES_PAINTING_PAINTERPATHS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/painting/painterpaths/painterpaths, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/painting/painterpaths/painterpaths)
endif

ifdef PTXCONF_QT4_EXAMPLES_PAINTING_SVGGENERATOR
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/painting/svggenerator/svggenerator, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/painting/svggenerator/svggenerator)
endif

ifdef PTXCONF_QT4_EXAMPLES_PAINTING_SVGVIEWER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/painting/svgviewer/svgviewer, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/painting/svgviewer/svgviewer)
endif

ifdef PTXCONF_QT4_EXAMPLES_PAINTING_TRANSFORMATIONS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/painting/transformations/transformations, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/painting/transformations/transformations)
endif

ifdef PTXCONF_QT4_EXAMPLES_PHONON_CAPABILITIES
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/phonon/capabilities/capabilities, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/phonon/capabilities/capabilities)
endif

ifdef PTXCONF_QT4_EXAMPLES_PHONON_QMUSICPLAYER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/phonon/qmusicplayer/qmusicplayer, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/phonon/qmusicplayer/qmusicplayer)
endif

ifdef PTXCONF_QT4_EXAMPLES_QTCONCURRENT_IMAGESCALING
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/qtconcurrent/imagescaling/imagescaling, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/qtconcurrent/imagescaling/imagescaling)
endif

ifdef PTXCONF_QT4_EXAMPLES_QTCONCURRENT_MAPDEMO
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/qtconcurrent/map/mapdemo, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/qtconcurrent/map/mapdemo)
endif

ifdef PTXCONF_QT4_EXAMPLES_QTCONCURRENT_PROGRESSDIALOG
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/qtconcurrent/progressdialog/progressdialog, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/qtconcurrent/progressdialog/progressdialog)
endif

ifdef PTXCONF_QT4_EXAMPLES_QTCONCURRENT_RUNFUNCTION
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/qtconcurrent/runfunction/runfunction, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/qtconcurrent/runfunction/runfunction)
endif

ifdef PTXCONF_QT4_EXAMPLES_QTCONCURRENT_WORDCOUNT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/qtconcurrent/wordcount/wordcount, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/qtconcurrent/wordcount/wordcount)
endif

ifdef PTXCONF_QT4_EXAMPLES_QTESTLIB_TUTORIAL1
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/qtestlib/tutorial1/tutorial1, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/qtestlib/tutorial1/tutorial1)
endif

ifdef PTXCONF_QT4_EXAMPLES_QTESTLIB_TUTORIAL2
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/qtestlib/tutorial2/tutorial2, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/qtestlib/tutorial2/tutorial2)
endif

ifdef PTXCONF_QT4_EXAMPLES_QTESTLIB_TUTORIAL3
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/qtestlib/tutorial3/tutorial3, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/qtestlib/tutorial3/tutorial3)
endif

ifdef PTXCONF_QT4_EXAMPLES_QTESTLIB_TUTORIAL4
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/qtestlib/tutorial4/tutorial4, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/qtestlib/tutorial4/tutorial4)
endif

ifdef PTXCONF_QT4_EXAMPLES_QTESTLIB_TUTORIAL5
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/qtestlib/tutorial5/tutorial5, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/qtestlib/tutorial5/tutorial5)
endif

ifdef PTXCONF_QT4_EXAMPLES_QWS_FRAMEBUFFER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/qws/framebuffer/framebuffer, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/qws/framebuffer/framebuffer)
endif

ifdef PTXCONF_QT4_EXAMPLES_QWS_MOUSECALIBRATION
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/qws/mousecalibration/mousecalibration, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/qws/mousecalibration/mousecalibration)
endif

ifdef PTXCONF_QT4_EXAMPLES_QWS_SIMPLEDECORATION
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/qws/simpledecoration/simpledecoration, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/qws/simpledecoration/simpledecoration)
endif

ifdef PTXCONF_QT4_EXAMPLES_RICHTEXT_CALENDAR
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/richtext/calendar/calendar, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/richtext/calendar/calendar)
endif

ifdef PTXCONF_QT4_EXAMPLES_RICHTEXT_ORDERFORM
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/richtext/orderform/orderform, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/richtext/orderform/orderform)
endif

ifdef PTXCONF_QT4_EXAMPLES_RICHTEXT_SYNTAXHIGHLIGHTER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/richtext/syntaxhighlighter/syntaxhighlighter, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/richtext/syntaxhighlighter/syntaxhighlighter)
endif

ifdef PTXCONF_QT4_EXAMPLES_RICHTEXT_TEXTOBJECT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/richtext/textobject/textobject, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/richtext/textobject/textobject)
endif

ifdef PTXCONF_QT4_EXAMPLES_SCRIPT_CONTEXT2D
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/script/context2d/context2d, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/script/context2d/context2d)
endif

ifdef PTXCONF_QT4_EXAMPLES_SCRIPT_CUSTOMCLASS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/script/customclass/customclass, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/script/customclass/customclass)
endif

ifdef PTXCONF_QT4_EXAMPLES_SCRIPT_DEFAULTPROTOTYPES
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/script/defaultprototypes/defaultprototypes, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/script/defaultprototypes/defaultprototypes)
endif

ifdef PTXCONF_QT4_EXAMPLES_SCRIPT_HELLOSCRIPT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/script/helloscript/helloscript, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/script/helloscript/helloscript)
endif

ifdef PTXCONF_QT4_EXAMPLES_SCRIPT_MARSHAL
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/script/marshal/marshal, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/script/marshal/marshal)
endif

ifdef PTXCONF_QT4_EXAMPLES_SCRIPT_QSCRIPT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/script/qscript/qscript, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/script/qscript/qscript)
endif

ifdef PTXCONF_QT4_EXAMPLES_SQL_CACHEDTABLE
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/sql/cachedtable/cachedtable, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/sql/cachedtable/cachedtable)
endif

ifdef PTXCONF_QT4_EXAMPLES_SQL_DRILLDOWN
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/sql/drilldown/drilldown, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/sql/drilldown/drilldown)
endif

ifdef PTXCONF_QT4_EXAMPLES_SQL_MASTERDETAIL
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/sql/masterdetail/masterdetail, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/sql/masterdetail/masterdetail)
endif

ifdef PTXCONF_QT4_EXAMPLES_SQL_QUERYMODEL
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/sql/querymodel/querymodel, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/sql/querymodel/querymodel)
endif

ifdef PTXCONF_QT4_EXAMPLES_SQL_RELATIONALTABLEMODEL
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/sql/relationaltablemodel/relationaltablemodel, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/sql/relationaltablemodel/relationaltablemodel)
endif

ifdef PTXCONF_QT4_EXAMPLES_SQL_SQLWIDGETMAPPER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/sql/sqlwidgetmapper/sqlwidgetmapper, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/sql/sqlwidgetmapper/sqlwidgetmapper)
endif

ifdef PTXCONF_QT4_EXAMPLES_SQL_TABLEMODEL
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/sql/tablemodel/tablemodel, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/sql/tablemodel/tablemodel)
endif

ifdef PTXCONF_QT4_EXAMPLES_STATEMACHINE_EVENTTRANSITIONS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/statemachine/eventtransitions/eventtransitions, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/statemachine/eventtransitions/eventtransitions)
endif

ifdef PTXCONF_QT4_EXAMPLES_STATEMACHINE_FACTORIAL
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/statemachine/factorial/factorial, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/statemachine/factorial/factorial)
endif

ifdef PTXCONF_QT4_EXAMPLES_STATEMACHINE_PINGPONG
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/statemachine/pingpong/pingpong, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/statemachine/pingpong/pingpong)
endif

ifdef PTXCONF_QT4_EXAMPLES_STATEMACHINE_ROGUE
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/statemachine/rogue/rogue, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/statemachine/rogue/rogue)
endif

ifdef PTXCONF_QT4_EXAMPLES_STATEMACHINE_TRAFFICLIGHT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/statemachine/trafficlight/trafficlight, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/statemachine/trafficlight/trafficlight)
endif

ifdef PTXCONF_QT4_EXAMPLES_STATEMACHINE_TWOWAYBUTTON
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/statemachine/twowaybutton/twowaybutton, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/statemachine/twowaybutton/twowaybutton)
endif

ifdef PTXCONF_QT4_EXAMPLES_THREADS_MANDELBROT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/threads/mandelbrot/mandelbrot, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/threads/mandelbrot/mandelbrot)
endif

ifdef PTXCONF_QT4_EXAMPLES_THREADS_SEMAPHORES
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/threads/semaphores/semaphores, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/threads/semaphores/semaphores)
endif

ifdef PTXCONF_QT4_EXAMPLES_THREADS_WAITCONDITIONS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/threads/waitconditions/waitconditions, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/threads/waitconditions/waitconditions)
endif

ifdef PTXCONF_QT4_EXAMPLES_TOOLS_CODECS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/tools/codecs/codecs, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tools/codecs/codecs)
endif

ifdef PTXCONF_QT4_EXAMPLES_TOOLS_COMPLETER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/tools/completer/completer, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tools/completer/completer)
endif

ifdef PTXCONF_QT4_EXAMPLES_TOOLS_CONTIGUOUSCACHE
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/tools/contiguouscache/contiguouscache, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tools/contiguouscache/contiguouscache)
endif

ifdef PTXCONF_QT4_EXAMPLES_TOOLS_CUSTOMCOMPLETER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/tools/customcompleter/customcompleter, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tools/customcompleter/customcompleter)
endif

ifdef PTXCONF_QT4_EXAMPLES_TOOLS_ECHOPLUGIN
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/tools/echoplugin/echowindow/../echoplugin, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tools/echoplugin/echowindow/../echoplugin)
endif

ifdef PTXCONF_QT4_EXAMPLES_TOOLS_I18N
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/tools/i18n/i18n, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tools/i18n/i18n)
endif

ifdef PTXCONF_QT4_EXAMPLES_TOOLS_INPUTPANEL
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/tools/inputpanel/inputpanel, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tools/inputpanel/inputpanel)
endif

ifdef PTXCONF_QT4_EXAMPLES_TOOLS_PLUGANDPAINT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/tools/plugandpaint/plugandpaint, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tools/plugandpaint/plugandpaint)
endif

ifdef PTXCONF_QT4_EXAMPLES_TOOLS_REGEXP
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/tools/regexp/regexp, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tools/regexp/regexp)
endif

ifdef PTXCONF_QT4_EXAMPLES_TOOLS_SETTINGSEDITOR
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/tools/settingseditor/settingseditor, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tools/settingseditor/settingseditor)
endif

ifdef PTXCONF_QT4_EXAMPLES_TOOLS_STYLEPLUGIN
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/tools/styleplugin/stylewindow/../styleplugin, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tools/styleplugin/stylewindow/../styleplugin)
endif

ifdef PTXCONF_QT4_EXAMPLES_TOOLS_TREEMODELCOMPLETER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/tools/treemodelcompleter/treemodelcompleter, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tools/treemodelcompleter/treemodelcompleter)
endif

ifdef PTXCONF_QT4_EXAMPLES_TOOLS_UNDOFRAMEWORK
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/tools/undoframework/undoframework, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tools/undoframework/undoframework)
endif

ifdef PTXCONF_QT4_EXAMPLES_TUTORIALS_PART1
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/tutorials/addressbook/part1/part1, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tutorials/addressbook/part1/part1)
endif

ifdef PTXCONF_QT4_EXAMPLES_TUTORIALS_PART2
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/tutorials/addressbook/part2/part2, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tutorials/addressbook/part2/part2)
endif

ifdef PTXCONF_QT4_EXAMPLES_TUTORIALS_PART3
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/tutorials/addressbook/part3/part3, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tutorials/addressbook/part3/part3)
endif

ifdef PTXCONF_QT4_EXAMPLES_TUTORIALS_PART4
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/tutorials/addressbook/part4/part4, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tutorials/addressbook/part4/part4)
endif

ifdef PTXCONF_QT4_EXAMPLES_TUTORIALS_PART5
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/tutorials/addressbook/part5/part5, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tutorials/addressbook/part5/part5)
endif

ifdef PTXCONF_QT4_EXAMPLES_TUTORIALS_PART6
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/tutorials/addressbook/part6/part6, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tutorials/addressbook/part6/part6)
endif

ifdef PTXCONF_QT4_EXAMPLES_TUTORIALS_PART7
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/tutorials/addressbook/part7/part7, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tutorials/addressbook/part7/part7)
endif

ifdef PTXCONF_QT4_EXAMPLES_TUTORIALS_CHILDWIDGET
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/tutorials/widgets/childwidget/childwidget, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tutorials/widgets/childwidget/childwidget)
endif

ifdef PTXCONF_QT4_EXAMPLES_TUTORIALS_NESTEDLAYOUTS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/tutorials/widgets/nestedlayouts/nestedlayouts, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tutorials/widgets/nestedlayouts/nestedlayouts)
endif

ifdef PTXCONF_QT4_EXAMPLES_TUTORIALS_TOPLEVEL
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/tutorials/widgets/toplevel/toplevel, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tutorials/widgets/toplevel/toplevel)
endif

ifdef PTXCONF_QT4_EXAMPLES_TUTORIALS_WINDOWLAYOUT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/tutorials/widgets/windowlayout/windowlayout, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/tutorials/widgets/windowlayout/windowlayout)
endif

ifdef PTXCONF_QT4_EXAMPLES_UITOOLS_MULTIPLEINHERITANCE
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/uitools/multipleinheritance/multipleinheritance, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/uitools/multipleinheritance/multipleinheritance)
endif

ifdef PTXCONF_QT4_EXAMPLES_UITOOLS_TEXTFINDER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/uitools/textfinder/textfinder, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/uitools/textfinder/textfinder)
endif

ifdef PTXCONF_QT4_EXAMPLES_WEBKIT_DOMTRAVERSAL
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/webkit/domtraversal/domtraversal, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/webkit/domtraversal/domtraversal)
endif

ifdef PTXCONF_QT4_EXAMPLES_WEBKIT_FANCYBROWSER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/webkit/fancybrowser/fancybrowser, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/webkit/fancybrowser/fancybrowser)
endif

ifdef PTXCONF_QT4_EXAMPLES_WEBKIT_FORMEXTRACTOR
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/webkit/formextractor/formextractor, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/webkit/formextractor/formextractor)
endif

ifdef PTXCONF_QT4_EXAMPLES_WEBKIT_PREVIEWER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/webkit/previewer/previewer, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/webkit/previewer/previewer)
endif

ifdef PTXCONF_QT4_EXAMPLES_WEBKIT_SIMPLESELECTOR
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/webkit/simpleselector/simpleselector, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/webkit/simpleselector/simpleselector)
endif

ifdef PTXCONF_QT4_EXAMPLES_WIDGETS_ANALOGCLOCK
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/widgets/analogclock/analogclock, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/widgets/analogclock/analogclock)
endif

ifdef PTXCONF_QT4_EXAMPLES_WIDGETS_CALCULATOR
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/widgets/calculator/calculator, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/widgets/calculator/calculator)
endif

ifdef PTXCONF_QT4_EXAMPLES_WIDGETS_CALENDARWIDGET
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/widgets/calendarwidget/calendarwidget, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/widgets/calendarwidget/calendarwidget)
endif

ifdef PTXCONF_QT4_EXAMPLES_WIDGETS_CHARACTERMAP
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/widgets/charactermap/charactermap, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/widgets/charactermap/charactermap)
endif

ifdef PTXCONF_QT4_EXAMPLES_WIDGETS_CODEEDITOR
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/widgets/codeeditor/codeeditor, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/widgets/codeeditor/codeeditor)
endif

ifdef PTXCONF_QT4_EXAMPLES_WIDGETS_DIGITALCLOCK
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/widgets/digitalclock/digitalclock, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/widgets/digitalclock/digitalclock)
endif

ifdef PTXCONF_QT4_EXAMPLES_WIDGETS_GROUPBOX
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/widgets/groupbox/groupbox, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/widgets/groupbox/groupbox)
endif

ifdef PTXCONF_QT4_EXAMPLES_WIDGETS_ICONS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/widgets/icons/icons, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/widgets/icons/icons)
endif

ifdef PTXCONF_QT4_EXAMPLES_WIDGETS_IMAGEVIEWER
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/widgets/imageviewer/imageviewer, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/widgets/imageviewer/imageviewer)
endif

ifdef PTXCONF_QT4_EXAMPLES_WIDGETS_LINEEDITS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/widgets/lineedits/lineedits, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/widgets/lineedits/lineedits)
endif

ifdef PTXCONF_QT4_EXAMPLES_WIDGETS_MOVIE
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/widgets/movie/movie, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/widgets/movie/movie)
endif

ifdef PTXCONF_QT4_EXAMPLES_WIDGETS_SCRIBBLE
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/widgets/scribble/scribble, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/widgets/scribble/scribble)
endif

ifdef PTXCONF_QT4_EXAMPLES_WIDGETS_SHAPEDCLOCK
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/widgets/shapedclock/shapedclock, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/widgets/shapedclock/shapedclock)
endif

ifdef PTXCONF_QT4_EXAMPLES_WIDGETS_SLIDERS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/widgets/sliders/sliders, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/widgets/sliders/sliders)
endif

ifdef PTXCONF_QT4_EXAMPLES_WIDGETS_SPINBOXES
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/widgets/spinboxes/spinboxes, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/widgets/spinboxes/spinboxes)
endif

ifdef PTXCONF_QT4_EXAMPLES_WIDGETS_STYLES
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/widgets/styles/styles, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/widgets/styles/styles)
endif

ifdef PTXCONF_QT4_EXAMPLES_WIDGETS_STYLESHEET
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/widgets/stylesheet/stylesheet, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/widgets/stylesheet/stylesheet)
endif

ifdef PTXCONF_QT4_EXAMPLES_WIDGETS_TABLET
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/widgets/tablet/tablet, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/widgets/tablet/tablet)
endif

ifdef PTXCONF_QT4_EXAMPLES_WIDGETS_TETRIX
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/widgets/tetrix/tetrix, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/widgets/tetrix/tetrix)
endif

ifdef PTXCONF_QT4_EXAMPLES_WIDGETS_TOOLTIPS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/widgets/tooltips/tooltips, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/widgets/tooltips/tooltips)
endif

ifdef PTXCONF_QT4_EXAMPLES_WIDGETS_VALIDATORS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/widgets/validators/validators, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/widgets/validators/validators)
endif

ifdef PTXCONF_QT4_EXAMPLES_WIDGETS_WIGGLY
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/widgets/wiggly/wiggly, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/widgets/wiggly/wiggly)
endif

ifdef PTXCONF_QT4_EXAMPLES_WIDGETS_WINDOWFLAGS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/widgets/windowflags/windowflags, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/widgets/windowflags/windowflags)
endif

ifdef PTXCONF_QT4_EXAMPLES_XML_DOMBOOKMARKS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/xml/dombookmarks/dombookmarks, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/xml/dombookmarks/dombookmarks)
endif

ifdef PTXCONF_QT4_EXAMPLES_XML_HTMLINFO
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/xml/htmlinfo/htmlinfo, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/xml/htmlinfo/htmlinfo)
endif

ifdef PTXCONF_QT4_EXAMPLES_XML_RSSLISTING
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/xml/rsslisting/rsslisting, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/xml/rsslisting/rsslisting)
endif

ifdef PTXCONF_QT4_EXAMPLES_XML_SAXBOOKMARKS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/xml/saxbookmarks/saxbookmarks, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/xml/saxbookmarks/saxbookmarks)
endif

ifdef PTXCONF_QT4_EXAMPLES_XML_STREAMBOOKMARKS
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/xml/streambookmarks/streambookmarks, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/xml/streambookmarks/streambookmarks)
endif

ifdef PTXCONF_QT4_EXAMPLES_XML_XMLSTREAMLINT
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/xml/xmlstreamlint/xmlstreamlint, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/xml/xmlstreamlint/xmlstreamlint)
endif

ifdef PTXCONF_QT4_EXAMPLES_XMLPATTERNS_FILETREE
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/xmlpatterns/filetree/filetree, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/xmlpatterns/filetree/filetree)
endif

ifdef PTXCONF_QT4_EXAMPLES_XMLPATTERNS_QOBJECTXMLMODEL
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/xmlpatterns/qobjectxmlmodel/qobjectxmlmodel, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/xmlpatterns/qobjectxmlmodel/qobjectxmlmodel)
endif

ifdef PTXCONF_QT4_EXAMPLES_XMLPATTERNS_RECIPES
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/xmlpatterns/recipes/recipes, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/xmlpatterns/recipes/recipes)
endif

ifdef PTXCONF_QT4_EXAMPLES_XMLPATTERNS_SCHEMA
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/xmlpatterns/schema/schema, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/xmlpatterns/schema/schema)
endif

ifdef PTXCONF_QT4_EXAMPLES_XMLPATTERNS_TRAFFICINFO
	@$(call install_copy, qt4-examples, 0, 0, 0755, \
		$(QT4_DIR)-build/examples/xmlpatterns/trafficinfo/trafficinfo, \
		$(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)/xmlpatterns/trafficinfo/trafficinfo)
endif


	@$(call install_finish, qt4-examples)
	@$(call touch, $@)

