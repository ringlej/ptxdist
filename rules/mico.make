# -*-makefile-*-
# $Id: template 4230 2006-01-17 10:58:03Z bbu $
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
PACKAGES-$(PTXCONF_MICO) += mico

#
# Paths and names
#
MICO_VERSION	= 2.3.12
MICO		= mico-$(MICO_VERSION)
MICO_SUFFIX	= tar.gz
MICO_URL	= http://www.mico.org/$(MICO).$(MICO_SUFFIX)
MICO_SOURCE	= $(SRCDIR)/$(MICO).$(MICO_SUFFIX)
MICO_DIR	= $(BUILDDIR)/$(MICO)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

mico_get: $(STATEDIR)/mico.get

$(STATEDIR)/mico.get: $(mico_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(MICO_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, MICO)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

mico_extract: $(STATEDIR)/mico.extract

$(STATEDIR)/mico.extract: $(mico_extract_deps_default)
	@$(call targetinfo, $@)
	rm -fr $(MICO_DIR)
	mkdir -p $(BUILDDIR)
	tmpdir=`mktemp -d`; \
	$(call extract, MICO, $$tmpdir) \
	mv $$tmpdir/mico $(MICO_DIR); \
	rm -fr $$tmpdir
	@$(call patchin, MICO)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

mico_prepare: $(STATEDIR)/mico.prepare

MICO_PATH	=  PATH=$(CROSS_PATH)
MICO_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
MICO_AUTOCONF =  --target=$(PTXCONF_GNU_TARGET)
MICO_AUTOCONF += --with-mico=$(PTXCONF_SYSROOT_TARGET)
# FIXME: this should be fixed upstream
MICO_AUTOCONF += --prefix=$(SYSROOT)

# doesn't work anyway
MICO_AUTOCONF += --disable-mini-stl

ifdef PTXCONF_MICO_THREAD
MICO_AUTOCONF += --enable-threads
else
MICO_AUTOCONF += --disable-threads
endif
ifdef PTXCONF_MICO_CCM
MICO_AUTOCONF += --enable-ccm
else
MICO_AUTOCONF += --disable-ccm
endif
ifdef PTXCONF_MICO_COSS
MICO_AUTOCONF += --enable-coss
else
MICO_AUTOCONF += --disable-coss
endif
ifdef PTXCONF_MICO_CSL2
MICO_AUTOCONF += --enable-csl2
else
MICO_AUTOCONF += --disable-csl2
endif
ifdef PTXCONF_MICO_CSIV2
MICO_AUTOCONF += --enable-csiv2
else
MICO_AUTOCONF += --disable-csiv2
endif
ifdef PTXCONF_MICO_SERVICE_NAMING
MICO_AUTOCONF += --enable-naming
else
MICO_AUTOCONF += --disable-naming
endif
ifdef PTXCONF_MICO_SERVICE_RELSHIP
MICO_AUTOCONF += --enable-relship
else
MICO_AUTOCONF += --disable-relship
endif
ifdef PTXCONF_MICO_SERVICE_EVENTS
MICO_AUTOCONF += --enable-events
else
MICO_AUTOCONF += --disable-events
endif
ifdef PTXCONF_MICO_SERVICE_STREAM
MICO_AUTOCONF += --enable-stream
else
MICO_AUTOCONF += --disable-stream
endif
ifdef PTXCONF_MICO_SERVICE_PROPERTY
MICO_AUTOCONF += --enable-property
else
MICO_AUTOCONF += --disable-property
endif
# FIXME: even with --disable-trader it tries to use it (tested with 2.3.12RC3)
#ifdef PTXCONF_MICO_SERVICE_TRADER
#MICO_AUTOCONF += --enable-trader
#else
#MICO_AUTOCONF += --disable-trader
#endif
ifdef PTXCONF_MICO_SERVICE_TIME
MICO_AUTOCONF += --enable-time
else
MICO_AUTOCONF += --disable-time
endif
# FIXME: lifecycle service doesn't compile with 2.3.12
#ifdef PTXCONF_MICO_SERVICE_LIFECYCLE
#MICO_AUTOCONF += --enable-life
#else
#MICO_AUTOCONF += --disable-life
#endif
MICO_AUTOCONF += --disable-life
ifdef PTXCONF_MICO_SERVICE_EXTERNALISATION
MICO_AUTOCONF += --enable-externalize
else
MICO_AUTOCONF += --disable-externalize
endif
ifdef PTXCONF_MICO_WIRELESS
MICO_AUTOCONF += --enable-wireless
else
MICO_AUTOCONF += --disable-wireless
endif
ifdef PTXCONF_MICO_WIRELESS_HOME
MICO_AUTOCONF += --enable-wireless-home
else
MICO_AUTOCONF += --disable-wireless-home
endif
ifdef PTXCONF_MICO_WIRELESS_TERMINAL
MICO_AUTOCONF += --enable-wireless-terminal
else
MICO_AUTOCONF += --disable-wireless-terminal
endif
ifdef PTXCONF_MICO_WIRELESS_ACCESS
MICO_AUTOCONF += --enable-wireless-access
else
MICO_AUTOCONF += --disable-wireless-access
endif
ifdef PTXCONF_MICO_REPO
MICO_AUTOCONF += --enable-repo
else
MICO_AUTOCONF += --disable-repo
endif
ifdef PTXCONF_MICO_MINI
MICO_AUTOCONF += --enable-minimum-corba
else
MICO_AUTOCONF += --disable-minimum-corba
endif

# FIXME: re-enable when X is there
MICO_AUTOCONF += --without-x

$(STATEDIR)/mico.prepare: $(mico_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(MICO_DIR)/config.cache)
	cd $(MICO_DIR) && \
		$(MICO_PATH) $(MICO_ENV) \
		./configure $(MICO_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

mico_compile: $(STATEDIR)/mico.compile

$(STATEDIR)/mico.compile: $(mico_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(MICO_DIR) && $(MICO_ENV) $(MICO_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

mico_install: $(STATEDIR)/mico.install

$(STATEDIR)/mico.install: $(mico_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install,MICO)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

mico_targetinstall: $(STATEDIR)/mico.targetinstall

$(STATEDIR)/mico.targetinstall: $(mico_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, mico)
	@$(call install_fixup, mico,PACKAGE,mico)
	@$(call install_fixup, mico,PRIORITY,optional)
	@$(call install_fixup, mico,VERSION,$(MICO_VERSION))
	@$(call install_fixup, mico,SECTION,base)
	@$(call install_fixup, mico,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, mico,DEPENDS,)
	@$(call install_fixup, mico,DESCRIPTION,missing)

ifdef PTXCONF_MICO_LIBMICOAUX
	@$(call install_copy, mico, 0, 0, 0644, \
		$(MICO_DIR)/libs/libmicoaux$(MICO_VERSION).so, \
		/usr/lib/libmicoaux$(MICO_VERSION).so)
endif
ifdef PTXCONF_MICO_LIBMICOCOSS
	@$(call install_copy, mico, 0, 0, 0644, \
		$(MICO_DIR)/libs/libmicocoss$(MICO_VERSION).so, \
		/usr/lib/libmicocoss$(MICO_VERSION).so)
endif
ifdef PTXCONF_MICO_LIBMICOIR
	@$(call install_copy, mico, 0, 0, 0644, \
		$(MICO_DIR)/libs/libmicoir$(MICO_VERSION).so, \
		/usr/lib/libmicoir$(MICO_VERSION).so)
endif
ifdef PTXCONF_MICO_LIBMICO
	@$(call install_copy, mico, 0, 0, 0644, \
		$(MICO_DIR)/libs/libmico$(MICO_VERSION).so, \
		/usr/lib/libmico$(MICO_VERSION).so)
endif
	@$(call install_finish, mico)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

mico_clean:
	rm -rf $(STATEDIR)/mico.*
	rm -rf $(PKGDIR)/mico_*
	rm -rf $(MICO_DIR)

# vim: syntax=make
