# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_COREUTILS) += coreutils

#
# Paths and names
#
COREUTILS_VERSION	:= 5.2.1
COREUTILS		:= coreutils-$(COREUTILS_VERSION)
COREUTILS_URL		:= $(PTXCONF_SETUP_GNUMIRROR)/coreutils/$(COREUTILS).tar.bz2
COREUTILS_SOURCE	:= $(SRCDIR)/$(COREUTILS).tar.bz2
COREUTILS_DIR		:= $(BUILDDIR)/$(COREUTILS)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

coreutils_get: $(STATEDIR)/coreutils.get

$(STATEDIR)/coreutils.get: $(coreutils_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(COREUTILS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, COREUTILS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

coreutils_extract: $(STATEDIR)/coreutils.extract

$(STATEDIR)/coreutils.extract: $(coreutils_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(COREUTILS_DIR))
	@$(call extract, COREUTILS)
	@$(call patchin, COREUTILS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

coreutils_prepare: $(STATEDIR)/coreutils.prepare

COREUTILS_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--target=$(PTXCONF_GNU_TARGET) \
	--disable-nls

COREUTILS_PATH	:=  PATH=$(CROSS_PATH)
COREUTILS_ENV	:=  $(CROSS_ENV)

$(STATEDIR)/coreutils.prepare: $(coreutils_prepare_deps_default)
	@$(call targetinfo, $@)

	cd $(COREUTILS_DIR) && \
		$(COREUTILS_PATH) $(COREUTILS_ENV) \
		./configure $(COREUTILS_AUTOCONF)

	cd $(COREUTILS_DIR)/src && make localedir.h

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

coreutils_compile_deps = $(STATEDIR)/coreutils.prepare

coreutils_compile: $(STATEDIR)/coreutils.compile

$(STATEDIR)/coreutils.compile: $(coreutils_compile_deps_default)
	@$(call targetinfo, $@)
	$(COREUTILS_PATH) make -C $(COREUTILS_DIR)/lib libfetish.a
ifdef PTXCONF_COREUTILS_CP
	$(COREUTILS_PATH) make -C $(COREUTILS_DIR)/src cp
endif
ifdef PTXCONF_COREUTILS_DD
	$(COREUTILS_PATH) make -C $(COREUTILS_DIR)/src dd
endif
ifdef PTXCONF_COREUTILS_MD5SUM
	$(COREUTILS_PATH) make -C $(COREUTILS_DIR)/src md5sum
endif
ifdef PTXCONF_COREUTILS_SEQ
	$(COREUTILS_PATH) make -C $(COREUTILS_DIR)/src seq
endif
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

coreutils_install: $(STATEDIR)/coreutils.install

$(STATEDIR)/coreutils.install: $(coreutils_install_deps_default)
	@$(call targetinfo, $@)
	# @$(call install, COREUTILS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

coreutils_targetinstall: $(STATEDIR)/coreutils.targetinstall

$(STATEDIR)/coreutils.targetinstall: $(coreutils_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, coreutils)
	@$(call install_fixup, coreutils,PACKAGE,coreutils)
	@$(call install_fixup, coreutils,PRIORITY,optional)
	@$(call install_fixup, coreutils,VERSION,$(COREUTILS_VERSION))
	@$(call install_fixup, coreutils,SECTION,base)
	@$(call install_fixup, coreutils,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, coreutils,DEPENDS,)
	@$(call install_fixup, coreutils,DESCRIPTION,missing)

ifdef PTXCONF_COREUTILS_CP
	@$(call install_copy, coreutils, 0, 0, 0755, $(COREUTILS_DIR)/src/cp, /bin/cp)
endif
ifdef PTXCONF_COREUTILS_DD
	@$(call install_copy, coreutils, 0, 0, 0755, $(COREUTILS_DIR)/src/dd, /bin/dd)
endif
ifdef PTXCONF_COREUTILS_MD5SUM
	@$(call install_copy, coreutils, 0, 0, 0755, $(COREUTILS_DIR)/src/md5sum, /usr/bin/md5sum)
endif
ifdef PTXCONF_COREUTILS_SEQ
	@$(call install_copy, coreutils, 0, 0, 0755, $(COREUTILS_DIR)/src/seq, /usr/bin/seq)
endif

	@$(call install_finish, coreutils)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

coreutils_clean:
	rm -rf $(STATEDIR)/coreutils.* $(COREUTILS_DIR)
	rm -fr $(IMAGEDIR)/coreutils_*

# vim: syntax=make
