# -*-makefile-*-
# $Id: template 4565 2006-02-10 14:23:10Z mkl $
#
# Copyright (C) 2006 by Erwin Rol
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_FONT_MISC_MISC) += xorg-font-misc-misc

#
# Paths and names
#
XORG_FONT_MISC_MISC_VERSION	:= 1.0.0
XORG_FONT_MISC_MISC		:= font-misc-misc-X11R7.0-$(XORG_FONT_MISC_MISC_VERSION)
XORG_FONT_MISC_MISC_SUFFIX	:= tar.bz2
XORG_FONT_MISC_MISC_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/X11R7.0/src/font//$(XORG_FONT_MISC_MISC).$(XORG_FONT_MISC_MISC_SUFFIX)
XORG_FONT_MISC_MISC_SOURCE	:= $(SRCDIR)/$(XORG_FONT_MISC_MISC).$(XORG_FONT_MISC_MISC_SUFFIX)
XORG_FONT_MISC_MISC_DIR		:= $(BUILDDIR)/$(XORG_FONT_MISC_MISC)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-font-misc-misc_get: $(STATEDIR)/xorg-font-misc-misc.get

$(STATEDIR)/xorg-font-misc-misc.get: $(xorg-font-misc-misc_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_FONT_MISC_MISC_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_FONT_MISC_MISC)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-font-misc-misc_extract: $(STATEDIR)/xorg-font-misc-misc.extract

$(STATEDIR)/xorg-font-misc-misc.extract: $(xorg-font-misc-misc_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_FONT_MISC_MISC_DIR))
	@$(call extract, XORG_FONT_MISC_MISC)
	@$(call patchin, XORG_FONT_MISC_MISC)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-font-misc-misc_prepare: $(STATEDIR)/xorg-font-misc-misc.prepare

XORG_FONT_MISC_MISC_PATH	:=  PATH=$(CROSS_PATH)
XORG_FONT_MISC_MISC_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_FONT_MISC_MISC_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-font-misc-misc.prepare: $(xorg-font-misc-misc_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_FONT_MISC_MISC_DIR)/config.cache)
	cd $(XORG_FONT_MISC_MISC_DIR) && \
		$(XORG_FONT_MISC_MISC_PATH) $(XORG_FONT_MISC_MISC_ENV) \
		./configure $(XORG_FONT_MISC_MISC_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-font-misc-misc_compile: $(STATEDIR)/xorg-font-misc-misc.compile

$(STATEDIR)/xorg-font-misc-misc.compile: $(xorg-font-misc-misc_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_FONT_MISC_MISC_DIR) && $(XORG_FONT_MISC_MISC_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-font-misc-misc_install: $(STATEDIR)/xorg-font-misc-misc.install

$(STATEDIR)/xorg-font-misc-misc.install: $(xorg-font-misc-misc_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-font-misc-misc_targetinstall: $(STATEDIR)/xorg-font-misc-misc.targetinstall

$(STATEDIR)/xorg-font-misc-misc.targetinstall: $(xorg-font-misc-misc_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-font-misc-misc)
	@$(call install_fixup, xorg-font-misc-misc,PACKAGE,xorg-font-misc-misc)
	@$(call install_fixup, xorg-font-misc-misc,PRIORITY,optional)
	@$(call install_fixup, xorg-font-misc-misc,VERSION,$(XORG_FONT_MISC_MISC_VERSION))
	@$(call install_fixup, xorg-font-misc-misc,SECTION,base)
	@$(call install_fixup, xorg-font-misc-misc,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-font-misc-misc,DEPENDS,)
	@$(call install_fixup, xorg-font-misc-misc,DESCRIPTION,missing)

	@cd $(XORG_FONT_MISC_MISC_DIR); \
	for file in `find . -name "*.pcf.gz" -a \! -name "*ISO8859*"`; do	\
		if [ -e $$file ]; then \
			$(call install_copy, xorg-font-misc-misc, 0, 0, 0644, $$file, $(XORG_FONTDIR)/misc/$$file, n); \
		fi; \
	done;

	@cd $(XORG_FONT_MISC_MISC_DIR); \
	for file in *{ISO8859-15,ISO8859-1,ISO8859-16,ISO8859-11}.pcf.gz; do \
		if [ -e $$file ]; then \
			$(call install_copy, xorg-font-misc-misc, 0, 0, 0644, $$file, $(XORG_FONTDIR)/misc/$$file, n); \
		fi; \
	done;

ifdef PTXCONF_XORG_FONT_MISC_MISC_TRANS
	@cd $(XORG_FONT_MISC_MISC_DIR); \
	for file in *{ISO8859-2,-ISO8859-3,ISO8859-4,ISO8859-9,ISO8859-10,ISO8859-13,ISO8859-14}.pcf.gz; do \
		if [ -e $$file ]; then \
			$(call install_copy, xorg-font-misc-misc, 0, 0, 0644, $$file, $(XORG_FONTDIR)/misc/$$file, n); \
		fi; \
	done;
endif

	@$(call install_finish, xorg-font-misc-misc)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-font-misc-misc_clean:
	rm -rf $(STATEDIR)/xorg-font-misc-misc.*
	rm -rf $(IMAGEDIR)/xorg-font-misc-misc_*
	rm -rf $(XORG_FONT_MISC_MISC_DIR)

# vim: syntax=make
