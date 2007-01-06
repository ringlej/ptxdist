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
PACKAGES-$(PTXCONF_SAMBA) += samba

#
# Paths and names
#
SAMBA_VERSION	:= 3.0.23d
SAMBA		:= samba-$(SAMBA_VERSION)
SAMBA_SUFFIX	:= tar.gz
SAMBA_URL	:= http://us5.samba.org/samba/ftp/$(SAMBA).$(SAMBA_SUFFIX)
SAMBA_SOURCE	:= $(SRCDIR)/$(SAMBA).$(SAMBA_SUFFIX)
SAMBA_DIR	:= $(BUILDDIR)/$(SAMBA)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

samba_get: $(STATEDIR)/samba.get

$(STATEDIR)/samba.get: $(samba_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(SAMBA_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, SAMBA)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

samba_extract: $(STATEDIR)/samba.extract

$(STATEDIR)/samba.extract: $(samba_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(SAMBA_DIR))
	@$(call extract, SAMBA)
	@$(call patchin, SAMBA)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

samba_prepare: $(STATEDIR)/samba.prepare

SAMBA_PATH	:= PATH=$(CROSS_PATH)

SAMBA_ENV 	:= \
	$(CROSS_ENV) \
	samba_cv_HAVE_GETTIMEOFDAY_TZ=yes

#
# autoconf
#
SAMBA_AUTOCONF := $(CROSS_AUTOCONF_USR)

ifdef PTXCONF_SAMBA_CUPS
SAMBA_AUTOCONF += --enable-cups
else
SAMBA_AUTOCONF += --disable-cups
endif

$(STATEDIR)/samba.prepare: $(samba_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(SAMBA_DIR)/config.cache)
	cd $(SAMBA_DIR)/source && \
		$(SAMBA_PATH) $(SAMBA_ENV) \
		./configure $(SAMBA_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

samba_compile: $(STATEDIR)/samba.compile

$(STATEDIR)/samba.compile: $(samba_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(SAMBA_DIR)/source && $(SAMBA_PATH) $(MAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

samba_install: $(STATEDIR)/samba.install

$(STATEDIR)/samba.install: $(samba_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

samba_targetinstall: $(STATEDIR)/samba.targetinstall

$(STATEDIR)/samba.targetinstall: $(samba_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, samba)
	@$(call install_fixup, samba,PACKAGE,samba)
	@$(call install_fixup, samba,PRIORITY,optional)
	@$(call install_fixup, samba,VERSION,$(SAMBA_VERSION))
	@$(call install_fixup, samba,SECTION,base)
	@$(call install_fixup, samba,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, samba,DEPENDS,)
	@$(call install_fixup, samba,DESCRIPTION,missing)

ifdef PTXCONF_SAMBA_SMBD
	@$(call install_copy, samba, 0, 0, 0755, $(SAMBA_DIR)/source/bin/smbd, /usr/sbin/smbd)
endif
ifdef PTXCONF_SAMBA_NMBD
	@$(call install_copy, samba, 0, 0, 0755, $(SAMBA_DIR)/source/bin/nmbd, /usr/sbin/nmbd)
endif

	@$(call install_finish, samba)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

samba_clean:
	rm -rf $(STATEDIR)/samba.*
	rm -rf $(IMAGEDIR)/samba_*
	rm -rf $(SAMBA_DIR)

# vim: syntax=make
