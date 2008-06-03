# -*-makefile-*-
# $Id: template 5041 2006-03-09 08:45:49Z mkl $
#
# Copyright (C) 2006 by Robert Schwebel <r.schwebel@pengutronix.de>
#                       Pengutronix <info@pengutronix.de>, Germany
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBOIL) += liboil

#
# Paths and names
#
LIBOIL_VERSION	:= 0.3.13
LIBOIL		:= liboil-$(LIBOIL_VERSION)
LIBOIL_SUFFIX	:= tar.gz
LIBOIL_URL	:= http://liboil.freedesktop.org/download/$(LIBOIL).$(LIBOIL_SUFFIX)
LIBOIL_SOURCE	:= $(SRCDIR)/$(LIBOIL).$(LIBOIL_SUFFIX)
LIBOIL_DIR	:= $(BUILDDIR)/$(LIBOIL)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

liboil_get: $(STATEDIR)/liboil.get

$(STATEDIR)/liboil.get: $(liboil_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LIBOIL_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LIBOIL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

liboil_extract: $(STATEDIR)/liboil.extract

$(STATEDIR)/liboil.extract: $(liboil_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBOIL_DIR))
	@$(call extract, LIBOIL)
	@$(call patchin, LIBOIL)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

liboil_prepare: $(STATEDIR)/liboil.prepare

LIBOIL_PATH	:= PATH=$(CROSS_PATH)
LIBOIL_ENV 	:= \
	$(CROSS_ENV)

#
# autoconf
#
LIBOIL_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/liboil.prepare: $(liboil_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBOIL_DIR)/config.cache)
	cd $(LIBOIL_DIR) && \
		$(LIBOIL_PATH) $(LIBOIL_ENV) \
		./configure $(LIBOIL_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

liboil_compile: $(STATEDIR)/liboil.compile

$(STATEDIR)/liboil.compile: $(liboil_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(LIBOIL_DIR) && $(LIBOIL_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

liboil_install: $(STATEDIR)/liboil.install

$(STATEDIR)/liboil.install: $(liboil_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, LIBOIL)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

liboil_targetinstall: $(STATEDIR)/liboil.targetinstall

$(STATEDIR)/liboil.targetinstall: $(liboil_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, liboil)
	@$(call install_fixup,liboil,PACKAGE,liboil)
	@$(call install_fixup,liboil,PRIORITY,optional)
	@$(call install_fixup,liboil,VERSION,$(LIBOIL_VERSION))
	@$(call install_fixup,liboil,SECTION,base)
	@$(call install_fixup,liboil,AUTHOR,"Guillaume GOURAT <guillaume.gourat\@nexvision.fr>")
	@$(call install_fixup,liboil,DEPENDS,)
	@$(call install_fixup,liboil,DESCRIPTION,missing)

	@$(call install_copy, liboil, 0, 0, 0644, $(LIBOIL_DIR)/liboil/.libs/liboil-0.3.so.0.1.0, /usr/lib/liboil-0.3.so.0.1.0, y)
	@$(call install_link, liboil, liboil-0.3.so.0.1.0, /usr/lib/liboil-0.3.so.0)
	@$(call install_link, liboil, liboil-0.3.so.0.1.0, /usr/lib/liboil-0.3.so)

	@$(call install_finish,liboil)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

liboil_clean:
	rm -rf $(STATEDIR)/liboil.*
	rm -rf $(PKGDIR)/liboil_*
	rm -rf $(LIBOIL_DIR)

# vim: syntax=make
