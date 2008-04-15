# -*-makefile-*-
# $Id: template 5709 2006-06-09 13:55:00Z mkl $
#
# Copyright (C) 2006-2008 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBICONV) += libiconv

#
# Paths and names
#
LIBICONV_VERSION	:= 1.12
LIBICONV		:= libiconv-$(LIBICONV_VERSION)
LIBICONV_SUFFIX		:= tar.gz
LIBICONV_URL		:= $(PTXCONF_SETUP_GNUMIRROR)/libiconv/$(LIBICONV).$(LIBICONV_SUFFIX)
LIBICONV_SOURCE		:= $(SRCDIR)/$(LIBICONV).$(LIBICONV_SUFFIX)
LIBICONV_DIR		:= $(BUILDDIR)/$(LIBICONV)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/libiconv.get:
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LIBICONV_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LIBICONV)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/libiconv.extract:
	@$(call targetinfo, $@)
	@$(call clean, $(LIBICONV_DIR))
	@$(call extract, LIBICONV)
	@$(call patchin, LIBICONV)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBICONV_PATH	:=  PATH=$(CROSS_PATH)
LIBICONV_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
LIBICONV_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-static

ifdef PTXCONF_LIBICONV_EXTRA_ENCODINGS
LIBICONV_AUTOCONF += --enable-extra-encodings
endif

$(STATEDIR)/libiconv.prepare:
	@$(call targetinfo, $@)
	@$(call clean, $(LIBICONV_DIR)/config.cache)
	cd $(LIBICONV_DIR) && \
		$(LIBICONV_PATH) $(LIBICONV_ENV) \
		./configure $(LIBICONV_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/libiconv.compile:
	@$(call targetinfo, $@)
	cd $(LIBICONV_DIR) && $(LIBICONV_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libiconv.install:
	@$(call targetinfo, $@)
	@$(call install, LIBICONV)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libiconv.targetinstall:
	@$(call targetinfo, $@)

	@$(call install_init, libiconv)
	@$(call install_fixup,libiconv,PACKAGE,libiconv)
	@$(call install_fixup,libiconv,PRIORITY,optional)
	@$(call install_fixup,libiconv,VERSION,$(LIBICONV_VERSION))
	@$(call install_fixup,libiconv,SECTION,base)
	@$(call install_fixup,libiconv,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,libiconv,DEPENDS,)
	@$(call install_fixup,libiconv,DESCRIPTION,missing)

	@$(call install_copy, libiconv, 0, 0, 0644, \
		$(LIBICONV_DIR)/lib/.libs/libiconv.so.2.4.0, \
		/usr/lib/libiconv.so.2.4.0)

	@$(call install_link, libiconv, libiconv.so.2.4.0, /usr/lib/libiconv.so.2)
	@$(call install_link, libiconv, libiconv.so.2.4.0, /usr/lib/libiconv.so)

	@$(call install_finish,libiconv)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libiconv_clean:
	rm -rf $(STATEDIR)/libiconv.*
	rm -rf $(IMAGEDIR)/libiconv_*
	rm -rf $(LIBICONV_DIR)

# vim: syntax=make
