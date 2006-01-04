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

blackbox_get_deps = $(BLACKBOX_SOURCE)

$(STATEDIR)/blackbox.get: $(blackbox_get_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(BLACKBOX_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(BLACKBOX_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

blackbox_extract: $(STATEDIR)/blackbox.extract

blackbox_extract_deps = $(call deps_extract, BLACKBOX)

$(STATEDIR)/blackbox.extract: $(blackbox_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(BLACKBOX_DIR))
	@$(call extract, $(BLACKBOX_SOURCE))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

blackbox_prepare: $(STATEDIR)/blackbox.prepare

#
# dependencies
#
blackbox_prepare_deps = $(call deps_prepare, BLACKBOX)

BLACKBOX_PATH	=  PATH=$(CROSS_PATH)
BLACKBOX_ENV 	=  $(CROSS_ENV)
#BLACKBOX_ENV	+=

#
# autoconf
#
BLACKBOX_AUTOCONF =  $(CROSS_AUTOCONF_USR)
BLACKBOX_AUTOCONF += -disable-nls

BLACKBOX_AUTOCONF	+= --x-includes=/home/koan/ptxdist/ptxdist-testing/root/usr/X11R6/include
BLACKBOX_AUTOCONF	+= --x-libraries=/home/koan/ptxdist/ptxdist-testing/root/usr/X11R6/lib

#BLACKBOX_AUTOCONF	+= --x-includes=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/X11 \
#BLACKBOX_AUTOCONF	+= --x-libraries=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib \

$(STATEDIR)/blackbox.prepare: $(blackbox_prepare_deps)
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

blackbox_compile_deps = $(call deps_compile, BLACKBOX)

$(STATEDIR)/blackbox.compile: $(blackbox_compile_deps)
	@$(call targetinfo, $@)
	$(BLACKBOX_PATH) make -C $(BLACKBOX_DIR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

blackbox_install: $(STATEDIR)/blackbox.install

blackbox_install_deps = $(call deps_install, BLACKBOX)

$(STATEDIR)/blackbox.install: $(blackbox_install_deps)
	@$(call targetinfo, $@)
	@$(call install, BLACKBOX)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

blackbox_targetinstall: $(STATEDIR)/blackbox.targetinstall

blackbox_targetinstall_deps = $(call deps_targetinstall, BLACKBOX)

$(STATEDIR)/blackbox.targetinstall: $(blackbox_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,blackbox)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(BLACKBOX_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(BLACKBOX_DIR)/src/blackbox, /usr/X11R6/bin/blackbox)
	@$(call install_copy, 0, 0, 0755, $(BLACKBOX_DIR)/util/bsetroot, /usr/X11R6/bin/bsetroot)

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

blackbox_clean:
	rm -rf $(STATEDIR)/blackbox.*
	rm -rf $(BLACKBOX_DIR)

# vim: syntax=make
