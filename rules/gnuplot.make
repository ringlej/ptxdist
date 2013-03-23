# -*-makefile-*-
#
# Copyright (C) 2004 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GNUPLOT) += gnuplot

#
# Paths and names
#
GNUPLOT_VERSION	:= 4.6.2
GNUPLOT_MAJ_VER := $(shell echo $(GNUPLOT_VERSION) | cut -d . -f 1-2)
GNUPLOT_MD5	:= 060e0a77cabb6d6055c5917b0f0b5769
GNUPLOT		:= gnuplot-$(GNUPLOT_VERSION)
GNUPLOT_SUFFIX	:= tar.gz
GNUPLOT_URL	:= $(call ptx/mirror, SF, gnuplot/$(GNUPLOT).$(GNUPLOT_SUFFIX))
GNUPLOT_SOURCE	:= $(SRCDIR)/$(GNUPLOT).$(GNUPLOT_SUFFIX)
GNUPLOT_DIR	:= $(BUILDDIR)/$(GNUPLOT)


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GNUPLOT_PATH	:= PATH=$(CROSS_PATH)
GNUPLOT_ENV	:= $(CROSS_ENV)

#
# autoconf
#
# 4.2.4: --disable-datastrings is broken
#        --disable-binary-data-file is broken
#
GNUPLOT_AUTOCONF = \
	$(CROSS_AUTOCONF_USR) \
	--disable-history-file \
	--disable-x11-mbfonts \
	--enable-binary-data-file \
	--disable-with-image \
	--disable-binary-x11-polygon \
	--disable-thin-splines \
	--enable-datastrings \
	--disable-histograms \
	--disable-objects \
	--disable-stringvariables \
	--disable-macros \
	--disable-iris \
	--disable-mgr \
	--disable-rgip \
	--disable-h3d-quadtree \
	--disable-h3d-gridbox \
	--disable-wxwidgets \
	--without-kpsexpand \
	--without-latex \
	--without-lasergnu \
	--without-linux-vga \
	--without-ggi \
	--without-xmi \
	--with-readline=builtin \
	--without-cwdrc \
	--without-lisp-files \
	--without-row-help \
	--without-tutorial \
	--without-wx-config \
	--without-lua \
	--$(call ptx/endis, PTXCONF_GNUPLOT_X)-mouse \
	--$(call ptx/wwo, PTXCONF_GNUPLOT_X)-x \
	--$(call ptx/wwo, PTXCONF_GNUPLOT_PLOT)-plot \
	--$(call ptx/wwo, PTXCONF_GNUPLOT_PNG)-png \
	--$(call ptx/wwo, PTXCONF_GNUPLOT_GD)-gd \
	--without-plot \
	--$(call ptx/wwo, PTXCONF_GNUPLOT_PDF)-pdf \
	--without-tutorial \
	--without-cairo

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/gnuplot.compile:
	@$(call targetinfo)
	cd $(GNUPLOT_DIR)/src && $(GNUPLOT_PATH) $(MAKE) gnuplot $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gnuplot.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gnuplot)
	@$(call install_fixup, gnuplot,PRIORITY,optional)
	@$(call install_fixup, gnuplot,SECTION,base)
	@$(call install_fixup, gnuplot,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, gnuplot,DESCRIPTION,missing)

	@$(call install_copy, gnuplot, 0, 0, 0755, -, /usr/bin/gnuplot)

ifdef PTXCONF_GNUPLOT_HELP
	@$(call install_copy, gnuplot, 0, 0, 0644, -, \
		/usr/share/gnuplot/$(GNUPLOT_MAJ_VER)/gnuplot.gih)
endif

ifdef PTXCONF_GNUPLOT_POSTSCRIPT
	@$(call install_tree, gnuplot, 0, 0, -, \
		/usr/share/gnuplot/$(GNUPLOT_MAJ_VER)/PostScript)
endif

ifdef PTXCONF_GNUPLOT_JS
	@$(call install_tree, gnuplot, 0, 0, -, \
		/usr/share/gnuplot/$(GNUPLOT_MAJ_VER)/js)
endif

ifdef PTXCONF_GNUPLOT_X
	@$(call install_copy, gnuplot, 0, 0, 0755, -, \
		/usr/libexec/gnuplot/$(GNUPLOT_MAJ_VER)/gnuplot_x11)
endif

	@$(call install_finish, gnuplot)

	@$(call touch)

# vim: syntax=make
