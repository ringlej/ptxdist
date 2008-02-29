# -*-makefile-*-
# $Id: template-make 7626 2007-11-26 10:27:03Z mkl $
#
# Copyright (C) 2007 by Luotao Fu <l.fu@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GWT) += gwt

#
# Paths and names
#
GWT_VERSION		:= 1.0.1
GWT			:= gwt-$(GWT_VERSION)
GWT_SUFFIX		:= tar.bz2
GWT_URL			:= file://${PTXDIST_WORKSPACE}/local_src/$(GWT).$(GWT_SUFFIX)
GWT_SOURCE		:= $(SRCDIR)/$(GWT).$(GWT_SUFFIX)
GWT_DIR			:= $(BUILDDIR)/$(GWT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

gwt_get: $(STATEDIR)/gwt.get

$(STATEDIR)/gwt.get: $(gwt_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(GWT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, GWT)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

gwt_extract: $(STATEDIR)/gwt.extract

$(STATEDIR)/gwt.extract: $(gwt_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(GWT_DIR))
	@$(call extract, GWT)
	cd $(GWT_DIR) && $(GWT_PATH) $(GWT_ENV) ./autogen.sh
	@$(call patchin, GWT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

gwt_prepare: $(STATEDIR)/gwt.prepare

GWT_PATH	:= PATH=$(CROSS_PATH)
GWT_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
GWT_AUTOCONF := $(CROSS_AUTOCONF_USR)

ifdef PTXCONF_GWT_GWTMM
GWT_AUTOCONF += --enable-gtkmm-bindings
else
GWT_AUTOCONF += --disable-gtkmm-bindings
endif

$(STATEDIR)/gwt.prepare: $(gwt_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(GWT_DIR)/config.cache)
	cd $(GWT_DIR) && \
		$(GWT_PATH) $(GWT_ENV) \
		./configure $(GWT_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

gwt_compile: $(STATEDIR)/gwt.compile

$(STATEDIR)/gwt.compile: $(gwt_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(GWT_DIR) && $(GWT_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

gwt_install: $(STATEDIR)/gwt.install

$(STATEDIR)/gwt.install: $(gwt_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, GWT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

gwt_targetinstall: $(STATEDIR)/gwt.targetinstall

$(STATEDIR)/gwt.targetinstall: $(gwt_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, gwt)
	@$(call install_fixup, gwt,PACKAGE,gwt)
	@$(call install_fixup, gwt,PRIORITY,optional)
	@$(call install_fixup, gwt,VERSION,$(GWT_VERSION))
	@$(call install_fixup, gwt,SECTION,base)
	@$(call install_fixup, gwt,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, gwt,DEPENDS,)
	@$(call install_fixup, gwt,DESCRIPTION,missing)

	@$(call install_copy, gwt, 0, 0, 0644,\
		$(GWT_DIR)/gwt/.libs/libgwt.so.1.0.0, /usr/lib/libgwt.so.1.0.0)
	@$(call install_link, gwt, libgwt.so.1.0.0, /usr/lib/libgwt.so.1)
	@$(call install_link, gwt, libgwt.so.1.0.0, /usr/lib/libgwt.so)
ifdef PTXCONF_GWT_GWTMM
	@$(call install_copy, gwt, 0, 0, 0644,\
		$(GWT_DIR)/gwtmm/gwtmm/.libs/libgwtmm.so.1.0.0, /usr/lib/libgwtmm.so.1.0.0)
	@$(call install_link, gwt, libgwtmm.so.1.0.0, /usr/lib/libgwtmm.so.1)
	@$(call install_link, gwt, libgwtmm.so.1.0.0, /usr/lib/libgwtmm.so)
endif

	@$(call install_finish, gwt)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gwt_clean:
	rm -rf $(STATEDIR)/gwt.*
	rm -rf $(IMAGEDIR)/gwt_*
	rm -rf $(GWT_DIR)

# vim: syntax=make
