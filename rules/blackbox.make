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
ifdef PTXCONF_BLACKBOX
PACKAGES += blackbox
endif

#
# Paths and names
#
BLACKBOX_VERSION	= 0.65.0
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
	touch $@

$(BLACKBOX_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(BLACKBOX_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

blackbox_extract: $(STATEDIR)/blackbox.extract

blackbox_extract_deps = $(STATEDIR)/blackbox.get

$(STATEDIR)/blackbox.extract: $(blackbox_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(BLACKBOX_DIR))
	@$(call extract, $(BLACKBOX_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

blackbox_prepare: $(STATEDIR)/blackbox.prepare

#
# dependencies
#
blackbox_prepare_deps = \
	$(STATEDIR)/blackbox.extract \
	$(STATEDIR)/virtual-xchain.install

BLACKBOX_PATH	=  PATH=$(CROSS_PATH)
BLACKBOX_ENV 	=  $(CROSS_ENV)
#BLACKBOX_ENV	+=

#
# autoconf
#
BLACKBOX_AUTOCONF =  $(CROSS_AUTOCONF)
BLACKBOX_AUTOCONF += --prefix=$(CROSS_LIB_DIR)
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
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

blackbox_compile: $(STATEDIR)/blackbox.compile

blackbox_compile_deps = $(STATEDIR)/blackbox.prepare

$(STATEDIR)/blackbox.compile: $(blackbox_compile_deps)
	@$(call targetinfo, $@)
	$(BLACKBOX_PATH) make -C $(BLACKBOX_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

blackbox_install: $(STATEDIR)/blackbox.install

$(STATEDIR)/blackbox.install: $(STATEDIR)/blackbox.compile
	@$(call targetinfo, $@)
	$(BLACKBOX_PATH) make -C $(BLACKBOX_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

blackbox_targetinstall: $(STATEDIR)/blackbox.targetinstall

blackbox_targetinstall_deps = $(STATEDIR)/blackbox.compile

$(STATEDIR)/blackbox.targetinstall: $(blackbox_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,blackbox)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(BLACKBOX_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,libc)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(BLACKBOX_DIR)/src/blackbox, /usr/X11R6/bin/blackbox)
	@$(call install_copy, 0, 0, 0755, $(BLACKBOX_DIR)/util/bsetroot, /usr/X11R6/bin/bsetroot)

	@$(call install_finish)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

blackbox_clean:
	rm -rf $(STATEDIR)/blackbox.*
	rm -rf $(BLACKBOX_DIR)

# vim: syntax=make
