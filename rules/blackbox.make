# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Marco Cavallini <m.cavallini@koansoftware.com>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BLACKBOX) += blackbox

#
# Paths and names
#
BLACKBOX_VERSION	= 0.70.1
BLACKBOX		= blackbox-$(BLACKBOX_VERSION)
BLACKBOX_SUFFIX		= tar.gz
BLACKBOX_URL		= $(PTXCONF_SETUP_SFMIRROR)/blackboxwm/$(BLACKBOX).$(BLACKBOX_SUFFIX)
BLACKBOX_SOURCE		= $(SRCDIR)/$(BLACKBOX).$(BLACKBOX_SUFFIX)
BLACKBOX_DIR		= $(BUILDDIR)/$(BLACKBOX)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

blackbox_get: $(STATEDIR)/blackbox.get

$(STATEDIR)/blackbox.get: $(blackbox_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(BLACKBOX_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, BLACKBOX)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

blackbox_extract: $(STATEDIR)/blackbox.extract

$(STATEDIR)/blackbox.extract: $(blackbox_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(BLACKBOX_DIR))
	@$(call extract, BLACKBOX)
	@$(call patchin, BLACKBOX)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

blackbox_prepare: $(STATEDIR)/blackbox.prepare

BLACKBOX_PATH	=  PATH=$(CROSS_PATH)
BLACKBOX_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
BLACKBOX_AUTOCONF	=  $(CROSS_AUTOCONF_USR)
BLACKBOX_AUTOCONF	+= --x-includes=$(SYSROOT)/usr/include
BLACKBOX_AUTOCONF	+= --x-libraries=$(SYSROOT)/usr/lib

$(STATEDIR)/blackbox.prepare: $(blackbox_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(BLACKBOX_DIR)/config.cache)
	cd $(BLACKBOX_DIR) && \
		$(BLACKBOX_PATH) $(BLACKBOX_ENV) \
		./configure $(BLACKBOX_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

blackbox_compile: $(STATEDIR)/blackbox.compile

$(STATEDIR)/blackbox.compile: $(blackbox_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(BLACKBOX_DIR) && \
		$(BLACKBOX_PATH) $(BLACKBOX_ENV) \
		make $(BLACKBOX_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

blackbox_install: $(STATEDIR)/blackbox.install

$(STATEDIR)/blackbox.install: $(blackbox_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, BLACKBOX)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

blackbox_targetinstall: $(STATEDIR)/blackbox.targetinstall

$(STATEDIR)/blackbox.targetinstall: $(blackbox_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, blackbox)
	@$(call install_fixup, blackbox,PACKAGE,blackbox)
	@$(call install_fixup, blackbox,PRIORITY,optional)
	@$(call install_fixup, blackbox,VERSION,$(BLACKBOX_VERSION))
	@$(call install_fixup, blackbox,SECTION,base)
	@$(call install_fixup, blackbox,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, blackbox,DEPENDS,)
	@$(call install_fixup, blackbox,DESCRIPTION,missing)

	@$(call install_copy, blackbox, 0, 0, 0755, $(BLACKBOX_DIR)/src/blackbox, /usr/X11R6/bin/blackbox)
	@$(call install_copy, blackbox, 0, 0, 0755, $(BLACKBOX_DIR)/util/bsetroot, /usr/X11R6/bin/bsetroot)

	@$(call install_finish, blackbox)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

blackbox_clean:
	rm -rf $(STATEDIR)/blackbox.*
	rm -rf $(BLACKBOX_DIR)

# vim: syntax=make
