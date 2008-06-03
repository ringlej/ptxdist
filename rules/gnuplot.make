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
GNUPLOT_VERSION	:= 4.2.2
GNUPLOT		:= gnuplot-$(GNUPLOT_VERSION)
GNUPLOT_SUFFIX	:= tar.gz
GNUPLOT_URL	:= $(PTXCONF_SETUP_SFMIRROR)/gnuplot/$(GNUPLOT).$(GNUPLOT_SUFFIX)
GNUPLOT_SOURCE	:= $(SRCDIR)/$(GNUPLOT).$(GNUPLOT_SUFFIX)
GNUPLOT_DIR	:= $(BUILDDIR)/$(GNUPLOT)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

gnuplot_get: $(STATEDIR)/gnuplot.get

$(STATEDIR)/gnuplot.get: $(gnuplot_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(GNUPLOT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, GNUPLOT)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

gnuplot_extract: $(STATEDIR)/gnuplot.extract

$(STATEDIR)/gnuplot.extract: $(gnuplot_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(GNUPLOT_DIR))
	@$(call extract, GNUPLOT)
	@$(call patchin, GNUPLOT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

gnuplot_prepare: $(STATEDIR)/gnuplot.prepare

GNUPLOT_PATH	:= PATH=$(CROSS_PATH)
GNUPLOT_ENV	:= $(CROSS_ENV)

#
# autoconf
#
GNUPLOT_AUTOCONF = \
	$(CROSS_AUTOCONF_USR) \
	--disable-history-file \
	--disable-mouse \
	--disable-pm3d \
	--disable-filledboxes \
	--disable-relative-boxwidth \
	--disable-defined-var \
	--disable-thin-splines \
	--disable-iris \
	--disable-mgr \
	\
	--disable-rgip \
	--disable-h3d-quadtree \
	--disable-h3d-gridbox \
	\
	--without-lasergnu \
	--without-gihdir \
	--without-linux-vga \
	--without-ggi \
	--without-xmi \
	--with-readline \
	\
	--without-cwdrc \
	--without-lisp-files \
	--without-row-help \
	--without-tutorial

ifdef PTXCONF_GNUPLOT_FITERRVARS
GNUPLOT_AUTOCONF += --enable-fiterrvars
else
GNUPLOT_AUTOCONF += --disable-fiterrvars
endif

ifdef PTXCONF_GNUPLOT_X
GNUPLOT_AUTOCONF += --with-x
else
GNUPLOT_AUTOCONF += --without-x
endif

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

ifdef PTXCONF_GNUPLOT_PDF
GNUPLOT_AUTOCONF += --with-pdf
else
GNUPLOT_AUTOCONF += --without-pdf
endif


$(STATEDIR)/gnuplot.prepare: $(gnuplot_prepare_deps_default)
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

$(STATEDIR)/gnuplot.compile: $(gnuplot_compile_deps_default)
	@$(call targetinfo, $@)

	cd $(GNUPLOT_DIR)/src && $(GNUPLOT_PATH) make gnuplot
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

gnuplot_install: $(STATEDIR)/gnuplot.install

$(STATEDIR)/gnuplot.install: $(gnuplot_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, GNUPLOT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

gnuplot_targetinstall: $(STATEDIR)/gnuplot.targetinstall

$(STATEDIR)/gnuplot.targetinstall: $(gnuplot_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, gnuplot)
	@$(call install_fixup, gnuplot,PACKAGE,gnuplot)
	@$(call install_fixup, gnuplot,PRIORITY,optional)
	@$(call install_fixup, gnuplot,VERSION,$(GNUPLOT_VERSION))
	@$(call install_fixup, gnuplot,SECTION,base)
	@$(call install_fixup, gnuplot,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, gnuplot,DEPENDS,)
	@$(call install_fixup, gnuplot,DESCRIPTION,missing)

	@$(call install_copy, gnuplot, 0, 0, 0755, $(GNUPLOT_DIR)/src/gnuplot, /usr/bin/gnuplot)

ifdef PTXCONF_GNUPLOT_X
	@$(call install_copy, gnuplot, 0, 0, 0755, $(GNUPLOT_DIR)/src/gnuplot_x11, /usr/libexec/gnuplot/4.0/gnuplot_x11)
endif

	@$(call install_finish, gnuplot)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gnuplot_clean:
	rm -rf $(STATEDIR)/gnuplot.*
	rm -rf $(PKGDIR)/gnuplot_*
	rm -rf $(GNUPLOT_DIR)

# vim: syntax=make
