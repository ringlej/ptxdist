# -*-makefile-*-
# $Id: template 2516 2005-04-25 10:29:55Z rsc $
#
# Copyright (C) 2005 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_CANUTILS) += canutils

#
# Paths and names
#
CANUTILS_VERSION	:= $(call remove_quotes, $(PTXCONF_CANUTILS_VERSION))
CANUTILS		:= canutils-$(CANUTILS_VERSION)
CANUTILS_SUFFIX		:= tar.bz2
CANUTILS_URL		= http://www.pengutronix.de/software/socket-can/download/canutils/v$(shell echo $(PTXCONF_CANUTILS_VERSION)|sed "s/\([0-9]*\).\([0-9]*\).\([0-9]*\)/\1.\2/")/$(CANUTILS).$(CANUTILS_SUFFIX)
CANUTILS_SOURCE		:= $(SRCDIR)/$(CANUTILS).$(CANUTILS_SUFFIX)
CANUTILS_DIR		:= $(BUILDDIR)/$(CANUTILS)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

canutils_get: $(STATEDIR)/canutils.get

$(STATEDIR)/canutils.get: $(canutils_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(CANUTILS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, CANUTILS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

canutils_extract: $(STATEDIR)/canutils.extract

$(STATEDIR)/canutils.extract: $(canutils_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(CANUTILS_DIR))
	@$(call extract, CANUTILS)
	@$(call patchin, CANUTILS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

canutils_prepare: $(STATEDIR)/canutils.prepare

CANUTILS_PATH	:=  PATH=$(CROSS_PATH)
CANUTILS_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
CANUTILS_AUTOCONF :=  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/canutils.prepare: $(canutils_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(CANUTILS_DIR)/config.cache)
	cd $(CANUTILS_DIR) && \
		$(CANUTILS_PATH) $(CANUTILS_ENV) \
		CPPFLAGS="-I${KERNEL_DIR}/include $${CPPFLAGS}" \
		./configure $(CANUTILS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

canutils_compile: $(STATEDIR)/canutils.compile

$(STATEDIR)/canutils.compile: $(canutils_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(CANUTILS_DIR) && $(CANUTILS_ENV) $(CANUTILS_PATH) $(MAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

canutils_install: $(STATEDIR)/canutils.install

$(STATEDIR)/canutils.install: $(canutils_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, CANUTILS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

canutils_targetinstall: $(STATEDIR)/canutils.targetinstall

$(STATEDIR)/canutils.targetinstall: $(canutils_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, canutils)
	@$(call install_fixup, canutils,PACKAGE,canutils)
	@$(call install_fixup, canutils,PRIORITY,optional)
	@$(call install_fixup, canutils,VERSION,$(CANUTILS_VERSION))
	@$(call install_fixup, canutils,SECTION,base)
	@$(call install_fixup, canutils,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, canutils,DEPENDS,)
	@$(call install_fixup, canutils,DESCRIPTION,missing)

ifdef PTXCONF_CANUTILS_CANCONFIG
	@$(call install_copy, canutils, 0, 0, 0755, $(CANUTILS_DIR)/src/canconfig, /sbin/canconfig)
endif
ifdef PTXCONF_CANUTILS_CANECHO
	@$(call install_copy, canutils, 0, 0, 0755, $(CANUTILS_DIR)/src/canecho,   /sbin/canecho)
endif
ifdef PTXCONF_CANUTILS_CANDUMP
	@$(call install_copy, canutils, 0, 0, 0755, $(CANUTILS_DIR)/src/candump,   /sbin/candump)
endif
ifdef PTXCONF_CANUTILS_CANSEND
	@$(call install_copy, canutils, 0, 0, 0755, $(CANUTILS_DIR)/src/cansend,   /sbin/cansend)
endif
ifdef PTXCONF_CANUTILS_CANSEQUENCE
	@$(call install_copy, canutils, 0, 0, 0755, $(CANUTILS_DIR)/src/cansequence, /sbin/cansequence)
endif
	@$(call install_finish, canutils)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

canutils_clean:
	rm -rf $(STATEDIR)/canutils.*
	rm -rf $(IMAGEDIR)/canutils_*
	rm -rf $(CANUTILS_DIR)

# vim: syntax=make
