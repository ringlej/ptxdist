# -*-makefile-*-
# $Id: template-make 7626 2007-11-26 10:27:03Z mkl $
#
# Copyright (C) 2008 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ATTR) += attr

#
# Paths and names
#
ATTR_VERSION	:= 2.4.41
ATTR		:= attr-$(ATTR_VERSION)
ATTR_SUFFIX	:= tar.gz
ATTR_URL	:= ftp://oss.sgi.com/projects/xfs/cmd_tars/attr_$(ATTR_VERSION)-1.$(ATTR_SUFFIX)
ATTR_SOURCE	:= $(SRCDIR)/attr_$(ATTR_VERSION)-1.$(ATTR_SUFFIX)
ATTR_DIR	:= $(BUILDDIR)/$(ATTR)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

attr_get: $(STATEDIR)/attr.get

$(STATEDIR)/attr.get: $(attr_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(ATTR_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, ATTR)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

attr_extract: $(STATEDIR)/attr.extract

$(STATEDIR)/attr.extract: $(attr_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(ATTR_DIR))
	@$(call extract, ATTR)
	@$(call patchin, ATTR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

attr_prepare: $(STATEDIR)/attr.prepare

ATTR_PATH	:= PATH=$(CROSS_PATH)
ATTR_ENV 	:= $(CROSS_ENV) \
	LIBTOOL=$(PTXCONF_SYSROOT_CROSS)/bin/libtool

#
# autoconf
#
ATTR_AUTOCONF := $(CROSS_AUTOCONF_USR)

ifdef PTXCONF_ATTR_GETTEXT
ATTR_AUTOCONF += --enable-gettext
else
ATTR_AUTOCONF += --disable-gettext
endif

$(STATEDIR)/attr.prepare: $(attr_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(ATTR_DIR)/config.cache)
	cd $(ATTR_DIR) && \
		$(ATTR_PATH) $(ATTR_ENV) \
		./configure $(ATTR_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

attr_compile: $(STATEDIR)/attr.compile

$(STATEDIR)/attr.compile: $(attr_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(ATTR_DIR) && $(ATTR_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

attr_install: $(STATEDIR)/attr.install

$(STATEDIR)/attr.install: $(attr_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, ATTR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

attr_targetinstall: $(STATEDIR)/attr.targetinstall

$(STATEDIR)/attr.targetinstall: $(attr_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, attr)
	@$(call install_fixup, attr,PACKAGE,attr)
	@$(call install_fixup, attr,PRIORITY,optional)
	@$(call install_fixup, attr,VERSION,$(ATTR_VERSION))
	@$(call install_fixup, attr,SECTION,base)
	@$(call install_fixup, attr,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, attr,DEPENDS,)
	@$(call install_fixup, attr,DESCRIPTION,missing)

	@$(call install_copy, attr, 0, 0, 0755, $(ATTR_DIR)/attr/attr, /usr/bin/attr)
	@$(call install_copy, attr, 0, 0, 0755, $(ATTR_DIR)/setfattr/setfattr, /usr/bin/setfattr)
	@$(call install_copy, attr, 0, 0, 0755, $(ATTR_DIR)/getfattr/getfattr, /usr/bin/getfattr)

	@$(call install_finish, attr)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

attr_clean:
	rm -rf $(STATEDIR)/attr.*
	rm -rf $(PKGDIR)/attr_*
	rm -rf $(ATTR_DIR)

# vim: syntax=make
