# -*-makefile-*-
# $Id$
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
GNUPLOT_VERSION		= 4.0.0
GNUPLOT			= gnuplot-$(GNUPLOT_VERSION)
GNUPLOT_SUFFIX		= tar.gz
GNUPLOT_URL		= ftp://ftp.gnuplot.info/pub/gnuplot/$(GNUPLOT).$(GNUPLOT_SUFFIX)
GNUPLOT_SOURCE		= $(SRCDIR)/$(GNUPLOT).$(GNUPLOT_SUFFIX)
GNUPLOT_DIR		= $(BUILDDIR)/$(GNUPLOT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

gnuplot_get: $(STATEDIR)/gnuplot.get

gnuplot_get_deps = $(GNUPLOT_SOURCE)

$(STATEDIR)/gnuplot.get: $(gnuplot_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(GNUPLOT))
	@$(call touch, $@)

$(GNUPLOT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(GNUPLOT_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

gnuplot_extract: $(STATEDIR)/gnuplot.extract

gnuplot_extract_deps = $(STATEDIR)/gnuplot.get

$(STATEDIR)/gnuplot.extract: $(gnuplot_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(GNUPLOT_DIR))
	@$(call extract, $(GNUPLOT_SOURCE))
	@$(call patchin, $(GNUPLOT))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

gnuplot_prepare: $(STATEDIR)/gnuplot.prepare

#
# dependencies
#
gnuplot_prepare_deps =  $(STATEDIR)/gnuplot.extract
gnuplot_prepare_deps += $(STATEDIR)/virtual-xchain.install
ifdef PTXCONF_GNUPLOT_PNG
gnuplot_prepare_deps += $(STATEDIR)/libpng125.install
endif

GNUPLOT_PATH	=  PATH=$(CROSS_PATH)
GNUPLOT_ENV 	=  $(CROSS_ENV)
GNUPLOT_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig
GNUPLOT_ENV	+= LIBPNG_CONFIG=$(CROSS_LIB_DIR)/bin/libpng-config

#
# autoconf
#
GNUPLOT_AUTOCONF =  $(CROSS_AUTOCONF_USR)
GNUPLOT_AUTOCONF += --disable-history-file
GNUPLOT_AUTOCONF += --disable-mouse
GNUPLOT_AUTOCONF += --disable-pm3d 
GNUPLOT_AUTOCONF += --disable-filledboxes
GNUPLOT_AUTOCONF += --disable-relative-boxwidth
GNUPLOT_AUTOCONF += --disable-defined-var
GNUPLOT_AUTOCONF += --disable-thin-splines
GNUPLOT_AUTOCONF += --disable-iris
GNUPLOT_AUTOCONF += --disable-mgr
ifdef PTXCONF_GNUPLOT_FITERRVARS
GNUPLOT_AUTOCONF += --enable-fiterrvars
else
GNUPLOT_AUTOCONF += --disable-fiterrvars
endif
GNUPLOT_AUTOCONF += --disable-rgip
GNUPLOT_AUTOCONF += --disable-h3d-quadtree
GNUPLOT_AUTOCONF += --disable-h3d-gridbox 
ifdef PTXCONF_GNUPLOT_X
GNUPLOT_AUTOCONF += --with-x
else
GNUPLOT_AUTOCONF += --without-x
endif
GNUPLOT_AUTOCONF += --without-lasergnu
GNUPLOT_AUTOCONF += --without-gihdir
GNUPLOT_AUTOCONF += --without-linux-vga
GNUPLOT_AUTOCONF += --without-ggi
GNUPLOT_AUTOCONF += --without-xmi
GNUPLOT_AUTOCONF += --with-readline
ifdef PTXCONF_GNUPLOT_PLOT
GNUPLOT_AUTOCONF += --with-plot
else
GNUPLOT_AUTOCONF += --without-plot
endif
ifdef PTXCONF_GNUPLOT_PNG
GNUPLOT_AUTOCONF += --with-png
else
GNUPLOT_AUTOCONF += --without-png
endif
ifdef PTXCONF_GNUPLOT_GD
GNUPLOT_AUTOCONF += --with-gd
else
GNUPLOT_AUTOCONF += --without-gd
endif
ifdef PTXCONF_GNUPLOT_GIF
GNUPLOT_AUTOCONF += --with-gif
else
GNUPLOT_AUTOCONF += --without-gif
endif
ifdef PTXCONF_GNUPLOT_PDF
GNUPLOT_AUTOCONF += --with-pdf
else
GNUPLOT_AUTOCONF += --without-pdf
endif
GNUPLOT_AUTOCONF += --without-cwdrc 
GNUPLOT_AUTOCONF += --without-lisp-files
GNUPLOT_AUTOCONF += --without-row-help
GNUPLOT_AUTOCONF += --without-tutorial

$(STATEDIR)/gnuplot.prepare: $(gnuplot_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(GNUPLOT_DIR)/config.cache)
	cd $(GNUPLOT_DIR) && \
		$(GNUPLOT_PATH) $(GNUPLOT_ENV) \
		./configure $(GNUPLOT_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

gnuplot_compile: $(STATEDIR)/gnuplot.compile

gnuplot_compile_deps = $(STATEDIR)/gnuplot.prepare

$(STATEDIR)/gnuplot.compile: $(gnuplot_compile_deps)
	@$(call targetinfo, $@)

	cd $(GNUPLOT_DIR)/src && $(GNUPLOT_ENV) $(GNUPLOT_PATH) make gnuplot
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

gnuplot_install: $(STATEDIR)/gnuplot.install

$(STATEDIR)/gnuplot.install: $(STATEDIR)/gnuplot.compile
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

gnuplot_targetinstall: $(STATEDIR)/gnuplot.targetinstall

gnuplot_targetinstall_deps =  $(STATEDIR)/gnuplot.compile
ifdef PTXCONF_GNUPLOT_PNG
gnuplot_targetinstall_deps += $(STATEDIR)/libpng125.targetinstall
endif

$(STATEDIR)/gnuplot.targetinstall: $(gnuplot_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,gnuplot)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(GNUPLOT_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(GNUPLOT_DIR)/src/gnuplot, /usr/bin/gnuplot)

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gnuplot_clean:
	rm -rf $(STATEDIR)/gnuplot.*
	rm -rf $(IMAGEDIR)/gnuplot_*
	rm -rf $(GNUPLOT_DIR)

# vim: syntax=make
