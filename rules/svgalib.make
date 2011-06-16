# -*-makefile-*-
#
# Copyright (C) 2011 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SVGALIB) += svgalib

#
# Paths and names
#
SVGALIB_VERSION	:= 1.9.25
SVGALIB_MD5	:= 4dda7e779e550b7404cfe118f1d74222
SVGALIB		:= svgalib-$(SVGALIB_VERSION)
SVGALIB_SUFFIX	:= tar.gz
SVGALIB_URL	:= http://www.svgalib.org/$(SVGALIB).$(SVGALIB_SUFFIX)
SVGALIB_SOURCE	:= $(SRCDIR)/$(SVGALIB).$(SVGALIB_SUFFIX)
SVGALIB_DIR	:= $(BUILDDIR)/$(SVGALIB)
SVGALIB_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SVGALIB_CONF_ENV	:= $(CROSS_ENV)
SVGALIB_CONF_ENV	+= S_KERNELRELEASE=$(PTXCONF_KERNEL_VERSION)
SVGALIB_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/svgalib.compile:
	@$(call targetinfo)

	cd $(SVGALIB_DIR) && $(SVGALIB_PATH) $(SVGALIB_CONF_ENV) \
		$(MAKE) $(PARALLELMFLAGS) $(SVGALIB_MAKEVARS) sharedlib/libvga.so.$(SVGALIB_VERSION)

	cd $(SVGALIB_DIR) && $(SVGALIB_PATH) $(SVGALIB_CONF_ENV) \
		$(MAKE) $(PARALLELMFLAGS) $(SVGALIB_MAKEVARS) sharedlib/libvgagl.so.$(SVGALIB_VERSION)

ifdef PTXCONF_SVGALIB_VGATEST
	cd $(SVGALIB_DIR)/demos && $(SVGALIB_PATH) $(SVGALIB_CONF_ENV) \
		$(MAKE) $(PARALLELMFLAGS) $(SVGALIB_MAKEVARS) vgatest
endif

	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/svgalib.install:
	@$(call targetinfo)
	mkdir -p $(SVGALIB_PKGDIR)/usr/lib
	cp "$(SVGALIB_DIR)/sharedlib/libvga.so.$(SVGALIB_VERSION)" "$(SVGALIB_PKGDIR)/usr/lib"
	ln -sf libvga.so.$(SVGALIB_VERSION) $(SVGALIB_PKGDIR)/usr/lib/libvga.so.1
	ln -sf libvga.so.$(SVGALIB_VERSION) $(SVGALIB_PKGDIR)/usr/lib/libvga.so
	cp "$(SVGALIB_DIR)/sharedlib/libvgagl.so.$(SVGALIB_VERSION)" "$(SVGALIB_PKGDIR)/usr/lib"
	ln -sf libvgagl.so.$(SVGALIB_VERSION) $(SVGALIB_PKGDIR)/usr/lib/libvgagl.so.1
	ln -sf libvgagl.so.$(SVGALIB_VERSION) $(SVGALIB_PKGDIR)/usr/lib/libvgagl.so
ifdef PTXCONF_SVGALIB_VGATEST
	mkdir -p $(SVGALIB_PKGDIR)/usr/bin
	cp "$(SVGALIB_DIR)/demos/vgatest" "$(SVGALIB_PKGDIR)/usr/bin/vgatest"
endif
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/svgalib.targetinstall:
	@$(call targetinfo)

	@$(call install_init, svgalib)
	@$(call install_fixup, svgalib,PRIORITY,optional)
	@$(call install_fixup, svgalib,SECTION,base)
	@$(call install_fixup, svgalib,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, svgalib,DESCRIPTION,missing)

	@$(call install_lib, svgalib, 0, 0, 0755, libvga)
	@$(call install_lib, svgalib, 0, 0, 0755, libvgagl)

ifdef PTXCONF_SVGALIB_VGATEST
	@$(call install_copy, svgalib, 0, 0, 0755, -, /usr/bin/vgatest)
endif

	@$(call install_finish, svgalib)

	@$(call touch)

# vim: syntax=make
