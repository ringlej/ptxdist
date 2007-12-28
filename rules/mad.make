# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Sascha Hauer <sascha.hauer@gyro-net.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MAD) += mad

#
# Paths and names
#
MAD_VERSION	= 0.14.2b
MAD		= mad-$(MAD_VERSION)
MAD_SUFFIX	= tar.gz
MAD_URL		= http://www.pengutronix.de/software/ptxdist/temporary-src/$(MAD).$(MAD_SUFFIX)
MAD_SOURCE	= $(SRCDIR)/$(MAD).$(MAD_SUFFIX)
MAD_DIR		= $(BUILDDIR)/$(MAD)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

mad_get: $(STATEDIR)/mad.get

$(STATEDIR)/mad.get: $(mad_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(MAD_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, MAD)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

mad_extract: $(STATEDIR)/mad.extract

$(STATEDIR)/mad.extract: $(mad_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(MAD_DIR))
	@$(call extract, MAD)
	@$(call patchin, MAD)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

mad_prepare: $(STATEDIR)/mad.prepare

MAD_PATH	=  PATH=$(CROSS_PATH)
MAD_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
MAD_AUTOCONF =  $(CROSS_AUTOCONF_USR) \
	--disable-debugging \
	--disable-profiling \
	--disable-nls \
	--without-esd \
	--disable-experimental \
	--disable-shared \
	--enable-static

ifdef PTXCONF_MAD_OPT_SPEED
MAD_AUTOCONF += --enable-speed
endif
ifdef PTXCONF_MAD_OPT_ACCURACY
MAD_AUTOCONF += --enable-accuracy
endif

ifdef PTXCONF_ARCH_ARM
MAD_AUTOCONF += --enable-fpm=arm
endif
ifdef PTXCONF_ARCH_X86
MAD_AUTOCONF += --enable-fpm=intel
endif
ifdef PTXCONF_ARCH_PPC
MAD_AUTOCONF += --enable-fpm=ppc
endif

# unhandled yet
# --enable-sso
# --disable-aso

$(STATEDIR)/mad.prepare: $(mad_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(MAD_DIR)/config.cache)
	cd $(MAD_DIR) && \
		$(MAD_PATH) $(MAD_ENV) \
		./configure $(MAD_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

mad_compile: $(STATEDIR)/mad.compile

$(STATEDIR)/mad.compile: $(mad_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(MAD_DIR) && $(MAD_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

mad_install: $(STATEDIR)/mad.install

$(STATEDIR)/mad.install: $(mad_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, MAD)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

mad_targetinstall: $(STATEDIR)/mad.targetinstall

$(STATEDIR)/mad.targetinstall: $(mad_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, mad)
	@$(call install_fixup, mad,PACKAGE,mad)
	@$(call install_fixup, mad,PRIORITY,optional)
	@$(call install_fixup, mad,VERSION,$(MAD_VERSION))
	@$(call install_fixup, mad,SECTION,base)
	@$(call install_fixup, mad,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, mad,DEPENDS,)
	@$(call install_fixup, mad,DESCRIPTION,missing)

	@$(call install_copy, mad, 0, 0, 0755, $(MAD_DIR)/madplay, \
		/usr/bin/madplay)

	@$(call install_finish, mad)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

mad_clean:
	rm -rf $(STATEDIR)/mad.*
	rm -rf $(IMAGEDIR)/mad_*
	rm -rf $(MAD_DIR)

# vim: syntax=make
