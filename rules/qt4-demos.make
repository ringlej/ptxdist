# WARNING: this file is generated with qt4_mk_demos.sh
# do not edit

ifdef PTXCONF_QT4_DEMOS
$(STATEDIR)/qt4.targetinstall.post: $(STATEDIR)/qt4.targetinstall3
endif

$(STATEDIR)/qt4.targetinstall3: $(STATEDIR)/qt4.targetinstall
	@$(call targetinfo)
	@$(call install_init, qt4-demos)
	@$(call install_fixup, qt4-demos,PRIORITY,optional)
	@$(call install_fixup, qt4-demos,SECTION,base)
	@$(call install_fixup, qt4-demos,AUTHOR,"Christian Hemp <c.hemp@phytec.de")
	@$(call install_fixup, qt4-demos,DESCRIPTION,missing)

ifdef PTXCONF_QT4_DEMOS_AFFINE
	@$(call install_copy, qt4-demos, 0, 0, 0755, \
		$(QT4_DIR)-build/demos/affine/affine, \
		$(PTXCONF_QT4_DEMOS_INSTALL_DIR)/affine/affine)
endif

ifdef PTXCONF_QT4_DEMOS_BOOKS
	@$(call install_copy, qt4-demos, 0, 0, 0755, \
		$(QT4_DIR)-build/demos/books/books, \
		$(PTXCONF_QT4_DEMOS_INSTALL_DIR)/books/books)
endif

ifdef PTXCONF_QT4_DEMOS_BOXES
	@$(call install_copy, qt4-demos, 0, 0, 0755, \
		$(QT4_DIR)-build/demos/boxes/boxes, \
		$(PTXCONF_QT4_DEMOS_INSTALL_DIR)/boxes/boxes)
endif

ifdef PTXCONF_QT4_DEMOS_BROWSER
	@$(call install_copy, qt4-demos, 0, 0, 0755, \
		$(QT4_DIR)-build/demos/browser/browser, \
		$(PTXCONF_QT4_DEMOS_INSTALL_DIR)/browser/browser)
endif

ifdef PTXCONF_QT4_DEMOS_CHIP
	@$(call install_copy, qt4-demos, 0, 0, 0755, \
		$(QT4_DIR)-build/demos/chip/chip, \
		$(PTXCONF_QT4_DEMOS_INSTALL_DIR)/chip/chip)
endif

ifdef PTXCONF_QT4_DEMOS_COMPOSITION
	@$(call install_copy, qt4-demos, 0, 0, 0755, \
		$(QT4_DIR)-build/demos/composition/composition, \
		$(PTXCONF_QT4_DEMOS_INSTALL_DIR)/composition/composition)
endif

ifdef PTXCONF_QT4_DEMOS_DECLARATIVE_MINEHUNT
	@$(call install_copy, qt4-demos, 0, 0, 0755, \
		$(QT4_DIR)-build/demos/declarative/minehunt/minehunt, \
		$(PTXCONF_QT4_DEMOS_INSTALL_DIR)/declarative/minehunt/minehunt)

endif

ifdef PTXCONF_QT4_DEMOS_DEFORM
	@$(call install_copy, qt4-demos, 0, 0, 0755, \
		$(QT4_DIR)-build/demos/deform/deform, \
		$(PTXCONF_QT4_DEMOS_INSTALL_DIR)/deform/deform)
endif

ifdef PTXCONF_QT4_DEMOS_EMBEDDED_ANOMALY
	@$(call install_copy, qt4-demos, 0, 0, 0755, \
		$(QT4_DIR)-build/demos/embedded/anomaly/anomaly, \
		$(PTXCONF_QT4_DEMOS_INSTALL_DIR)/embedded/anomaly/anomaly)

endif

ifdef PTXCONF_QT4_DEMOS_EMBEDDED_DESKTOPSERVICES
	@$(call install_copy, qt4-demos, 0, 0, 0755, \
		$(QT4_DIR)-build/demos/embedded/desktopservices/desktopservices, \
		$(PTXCONF_QT4_DEMOS_INSTALL_DIR)/embedded/desktopservices/desktopservices)

endif

ifdef PTXCONF_QT4_DEMOS_EMBEDDED_DIGIFLIP
	@$(call install_copy, qt4-demos, 0, 0, 0755, \
		$(QT4_DIR)-build/demos/embedded/digiflip/digiflip, \
		$(PTXCONF_QT4_DEMOS_INSTALL_DIR)/embedded/digiflip/digiflip)

endif

ifdef PTXCONF_QT4_DEMOS_EMBEDDED_EMBEDDEDSVGVIEWER
	@$(call install_copy, qt4-demos, 0, 0, 0755, \
		$(QT4_DIR)-build/demos/embedded/embeddedsvgviewer/embeddedsvgviewer, \
		$(PTXCONF_QT4_DEMOS_INSTALL_DIR)/embedded/embeddedsvgviewer/embeddedsvgviewer)

endif

ifdef PTXCONF_QT4_DEMOS_EMBEDDED_FLICKABLE
	@$(call install_copy, qt4-demos, 0, 0, 0755, \
		$(QT4_DIR)-build/demos/embedded/flickable/flickable, \
		$(PTXCONF_QT4_DEMOS_INSTALL_DIR)/embedded/flickable/flickable)

endif

ifdef PTXCONF_QT4_DEMOS_EMBEDDED_FLIGHTINFO
	@$(call install_copy, qt4-demos, 0, 0, 0755, \
		$(QT4_DIR)-build/demos/embedded/flightinfo/flightinfo, \
		$(PTXCONF_QT4_DEMOS_INSTALL_DIR)/embedded/flightinfo/flightinfo)

endif

ifdef PTXCONF_QT4_DEMOS_EMBEDDED_FLUIDLAUNCHER
	@$(call install_copy, qt4-demos, 0, 0, 0755, \
		$(QT4_DIR)-build/demos/embedded/fluidlauncher/fluidlauncher, \
		$(PTXCONF_QT4_DEMOS_INSTALL_DIR)/embedded/fluidlauncher/fluidlauncher)

ifdef PTXCONF_QT4_DEMOS_EMBEDDED_FLUIDLAUNCHER_LOCALCONFIG
	@$(call install_tree, qt4-demos, 0, 0, \
		${PTXDIST_WORKSPACE}/projectroot$(PTXCONF_QT4_DEMOS_INSTALL_DIR)/embedded/fluidlauncher/screenshots, \
		$(PTXCONF_QT4_DEMOS_INSTALL_DIR)/embedded/fluidlauncher/screenshots)
	@$(call install_tree, qt4-demos, 0, 0, \
		${PTXDIST_WORKSPACE}/projectroot$(PTXCONF_QT4_DEMOS_INSTALL_DIR)/embedded/fluidlauncher/slides, \
		$(PTXCONF_QT4_DEMOS_INSTALL_DIR)/embedded/fluidlauncher/slides)
	@$(call install_alternative, qt4-demos, 0, 0, 0644, \
		$(PTXCONF_QT4_DEMOS_INSTALL_DIR)/embedded/fluidlauncher/config.xml)
else
	@$(call install_tree, qt4-demos, 0, 0, \
		$(QT4_DIR)/demos/embedded/fluidlauncher/screenshots, \
		$(PTXCONF_QT4_DEMOS_INSTALL_DIR)/embedded/fluidlauncher/screenshots)
	@$(call install_tree, qt4-demos, 0, 0, \
		$(QT4_DIR)/demos/embedded/fluidlauncher/slides, \
		$(PTXCONF_QT4_DEMOS_INSTALL_DIR)/embedded/fluidlauncher/slides)
	@$(call install_copy, qt4-demos, 0, 0, 0644, \
		$(QT4_DIR)/demos/embedded/fluidlauncher/config.xml, \
		$(PTXCONF_QT4_DEMOS_INSTALL_DIR)/embedded/fluidlauncher/config.xml)
endif

endif

ifdef PTXCONF_QT4_DEMOS_EMBEDDED_LIGHTMAPS
	@$(call install_copy, qt4-demos, 0, 0, 0755, \
		$(QT4_DIR)-build/demos/embedded/lightmaps/lightmaps, \
		$(PTXCONF_QT4_DEMOS_INSTALL_DIR)/embedded/lightmaps/lightmaps)

endif

ifdef PTXCONF_QT4_DEMOS_EMBEDDED_RAYCASTING
	@$(call install_copy, qt4-demos, 0, 0, 0755, \
		$(QT4_DIR)-build/demos/embedded/raycasting/raycasting, \
		$(PTXCONF_QT4_DEMOS_INSTALL_DIR)/embedded/raycasting/raycasting)

endif

ifdef PTXCONF_QT4_DEMOS_EMBEDDED_STYLEDEMO
	@$(call install_copy, qt4-demos, 0, 0, 0755, \
		$(QT4_DIR)-build/demos/embedded/styledemo/styledemo, \
		$(PTXCONF_QT4_DEMOS_INSTALL_DIR)/embedded/styledemo/styledemo)

endif

ifdef PTXCONF_QT4_DEMOS_EMBEDDED_WEATHERINFO
	@$(call install_copy, qt4-demos, 0, 0, 0755, \
		$(QT4_DIR)-build/demos/embedded/weatherinfo/weatherinfo, \
		$(PTXCONF_QT4_DEMOS_INSTALL_DIR)/embedded/weatherinfo/weatherinfo)

endif

ifdef PTXCONF_QT4_DEMOS_EMBEDDEDDIALOGS
	@$(call install_copy, qt4-demos, 0, 0, 0755, \
		$(QT4_DIR)-build/demos/embeddeddialogs/embeddeddialogs, \
		$(PTXCONF_QT4_DEMOS_INSTALL_DIR)/embeddeddialogs/embeddeddialogs)
endif

ifdef PTXCONF_QT4_DEMOS_GRADIENTS
	@$(call install_copy, qt4-demos, 0, 0, 0755, \
		$(QT4_DIR)-build/demos/gradients/gradients, \
		$(PTXCONF_QT4_DEMOS_INSTALL_DIR)/gradients/gradients)
endif

ifdef PTXCONF_QT4_DEMOS_INTERVIEW
	@$(call install_copy, qt4-demos, 0, 0, 0755, \
		$(QT4_DIR)-build/demos/interview/interview, \
		$(PTXCONF_QT4_DEMOS_INSTALL_DIR)/interview/interview)
endif

ifdef PTXCONF_QT4_DEMOS_MAINWINDOW
	@$(call install_copy, qt4-demos, 0, 0, 0755, \
		$(QT4_DIR)-build/demos/mainwindow/mainwindow, \
		$(PTXCONF_QT4_DEMOS_INSTALL_DIR)/mainwindow/mainwindow)
endif

ifdef PTXCONF_QT4_DEMOS_PATHSTROKE
	@$(call install_copy, qt4-demos, 0, 0, 0755, \
		$(QT4_DIR)-build/demos/pathstroke/pathstroke, \
		$(PTXCONF_QT4_DEMOS_INSTALL_DIR)/pathstroke/pathstroke)
endif

ifdef PTXCONF_QT4_DEMOS_QMEDIAPLAYER
	@$(call install_copy, qt4-demos, 0, 0, 0755, \
		$(QT4_DIR)-build/demos/qmediaplayer/qmediaplayer, \
		$(PTXCONF_QT4_DEMOS_INSTALL_DIR)/qmediaplayer/qmediaplayer)
endif

ifdef PTXCONF_QT4_DEMOS_QTDEMO
	@$(call install_copy, qt4-demos, 0, 0, 0755, \
		$(QT4_DIR)-build/demos/qtdemo/../../bin/qtdemo, \
		$(PTXCONF_QT4_DEMOS_INSTALL_DIR)/qtdemo/../../bin/qtdemo)
endif

ifdef PTXCONF_QT4_DEMOS_SPREADSHEET
	@$(call install_copy, qt4-demos, 0, 0, 0755, \
		$(QT4_DIR)-build/demos/spreadsheet/spreadsheet, \
		$(PTXCONF_QT4_DEMOS_INSTALL_DIR)/spreadsheet/spreadsheet)
endif

ifdef PTXCONF_QT4_DEMOS_SQLBROWSER
	@$(call install_copy, qt4-demos, 0, 0, 0755, \
		$(QT4_DIR)-build/demos/sqlbrowser/sqlbrowser, \
		$(PTXCONF_QT4_DEMOS_INSTALL_DIR)/sqlbrowser/sqlbrowser)
endif

ifdef PTXCONF_QT4_DEMOS_SUB_ATTAQ
	@$(call install_copy, qt4-demos, 0, 0, 0755, \
		$(QT4_DIR)-build/demos/sub-attaq/sub-attaq, \
		$(PTXCONF_QT4_DEMOS_INSTALL_DIR)/sub-attaq/sub-attaq)
endif

ifdef PTXCONF_QT4_DEMOS_TEXTEDIT
	@$(call install_copy, qt4-demos, 0, 0, 0755, \
		$(QT4_DIR)-build/demos/textedit/textedit, \
		$(PTXCONF_QT4_DEMOS_INSTALL_DIR)/textedit/textedit)
endif

ifdef PTXCONF_QT4_DEMOS_UNDO
	@$(call install_copy, qt4-demos, 0, 0, 0755, \
		$(QT4_DIR)-build/demos/undo/undo, \
		$(PTXCONF_QT4_DEMOS_INSTALL_DIR)/undo/undo)
endif


	@$(call install_finish, qt4-demos)
	@$(call touch)

# vim: syntax=make
