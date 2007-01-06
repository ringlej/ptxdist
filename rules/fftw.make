# -*-makefile-*-
# $Id: template 6487 2006-12-07 20:55:55Z rsc $
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
PACKAGES-$(PTXCONF_FFTW) += fftw

#
# Paths and names
#
FFTW_VERSION	:= 3.1.2
FFTW		:= fftw-$(FFTW_VERSION)
FFTW_SUFFIX	:= tar.gz
FFTW_URL	:= http://www.fftw.org//$(FFTW).$(FFTW_SUFFIX)
FFTW_SOURCE	:= $(SRCDIR)/$(FFTW).$(FFTW_SUFFIX)
FFTW_DIR	:= $(BUILDDIR)/$(FFTW)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

fftw_get: $(STATEDIR)/fftw.get

$(STATEDIR)/fftw.get: $(fftw_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(FFTW_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, FFTW)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

fftw_extract: $(STATEDIR)/fftw.extract

$(STATEDIR)/fftw.extract: $(fftw_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(FFTW_DIR))
	@$(call extract, FFTW)
	@$(call patchin, FFTW)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

fftw_prepare: $(STATEDIR)/fftw.prepare

FFTW_PATH	:= PATH=$(CROSS_PATH)
FFTW_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
FFTW_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-shared

$(STATEDIR)/fftw.prepare: $(fftw_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(FFTW_DIR)/config.cache)
	cd $(FFTW_DIR) && \
		$(FFTW_PATH) $(FFTW_ENV) \
		./configure $(FFTW_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

fftw_compile: $(STATEDIR)/fftw.compile

$(STATEDIR)/fftw.compile: $(fftw_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(FFTW_DIR) && $(FFTW_PATH) $(MAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

fftw_install: $(STATEDIR)/fftw.install

$(STATEDIR)/fftw.install: $(fftw_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, FFTW)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

fftw_targetinstall: $(STATEDIR)/fftw.targetinstall

$(STATEDIR)/fftw.targetinstall: $(fftw_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, fftw)
	@$(call install_fixup, fftw,PACKAGE,fftw)
	@$(call install_fixup, fftw,PRIORITY,optional)
	@$(call install_fixup, fftw,VERSION,$(FFTW_VERSION))
	@$(call install_fixup, fftw,SECTION,base)
	@$(call install_fixup, fftw,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, fftw,DEPENDS,)
	@$(call install_fixup, fftw,DESCRIPTION,missing)

	@$(call install_copy, fftw, 0, 0, 0644, $(FFTW_DIR)/.libs/libfftw3.so.3.1.2, /usr/lib/libfftw3.so.3.1.2)
	@$(call install_link, fftw, libfftw3.so.3.1.2, /usr/lib/libfftw3.so.3)
	@$(call install_link, fftw, libfftw3.so.3.1.2, /usr/lib/libfftw3.so)

	@$(call install_finish, fftw)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

fftw_clean:
	rm -rf $(STATEDIR)/fftw.*
	rm -rf $(IMAGEDIR)/fftw_*
	rm -rf $(FFTW_DIR)

# vim: syntax=make
