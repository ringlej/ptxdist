# -*-makefile-*-
# $Id: template 3691 2006-01-02 15:52:13Z rsc $
#
# Copyright (C) 2006 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBMQUEUE) += libmqueue

#
# Paths and names
#
LIBMQUEUE_VERSION	= 4.41
LIBMQUEUE		= libmqueue-$(LIBMQUEUE_VERSION)
LIBMQUEUE_SUFFIX	= tar.gz
LIBMQUEUE_URL		= http://www.geocities.com/wronski12/posix_ipc/$(LIBMQUEUE).$(LIBMQUEUE_SUFFIX)
LIBMQUEUE_SOURCE	= $(SRCDIR)/$(LIBMQUEUE).$(LIBMQUEUE_SUFFIX)
LIBMQUEUE_DIR		= $(BUILDDIR)/$(LIBMQUEUE)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libmqueue_get: $(STATEDIR)/libmqueue.get

$(STATEDIR)/libmqueue.get: $(LIBMQUEUE_SOURCE)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LIBMQUEUE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(LIBMQUEUE_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libmqueue_extract: $(STATEDIR)/libmqueue.extract

$(STATEDIR)/libmqueue.extract: $(libmqueue_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBMQUEUE_DIR))
	@$(call extract, $(LIBMQUEUE_SOURCE))
	@$(call patchin, $(LIBMQUEUE))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libmqueue_prepare: $(STATEDIR)/libmqueue.prepare

LIBMQUEUE_PATH	=  PATH=$(CROSS_PATH)
LIBMQUEUE_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
LIBMQUEUE_AUTOCONF =  $(CROSS_AUTOCONF_USR)
LIBMQUEUE_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/libmqueue.prepare: $(libmqueue_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBMQUEUE_DIR)/config.cache)
	cd $(LIBMQUEUE_DIR) && \
		$(LIBMQUEUE_PATH) $(LIBMQUEUE_ENV) \
		./configure $(LIBMQUEUE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

libmqueue_compile: $(STATEDIR)/libmqueue.compile

$(STATEDIR)/libmqueue.compile: $(libmqueue_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(LIBMQUEUE_DIR) && $(LIBMQUEUE_ENV) $(LIBMQUEUE_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libmqueue_install: $(STATEDIR)/libmqueue.install

$(STATEDIR)/libmqueue.install: $(STATEDIR)/libmqueue.compile
	@$(call targetinfo, $@)
	@$(call install, LIBMQUEUE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libmqueue_targetinstall: $(STATEDIR)/libmqueue.targetinstall

$(STATEDIR)/libmqueue.targetinstall: $(libmqueue_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,libmqueue)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(LIBMQUEUE_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(LIBMQUEUE_DIR)/foobar, /dev/null)

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libmqueue_clean:
	rm -rf $(STATEDIR)/libmqueue.*
	rm -rf $(IMAGEDIR)/libmqueue_*
	rm -rf $(LIBMQUEUE_DIR)

# vim: syntax=make
