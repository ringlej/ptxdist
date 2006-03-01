# -*-makefile-*-
# $Id$
#
# Copyright (C) 2002 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GRUB) += grub

#
# Paths and names 
#
GRUB_VERSION		:= 0.97
GRUB			:= grub-$(GRUB_VERSION)
GRUB_URL		:= ftp://alpha.gnu.org/gnu/grub/$(GRUB).tar.gz
GRUB_SOURCE		:= $(SRCDIR)/$(GRUB).tar.gz
GRUB_DIR		:= $(BUILDDIR)/$(GRUB)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

grub_get: $(STATEDIR)/grub.get

$(STATEDIR)/grub.get: $(grub_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(GRUB_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(GRUB_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

grub_extract: $(STATEDIR)/grub.extract

$(STATEDIR)/grub.extract: $(grub_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(GRUB_DIR))
	@$(call extract, $(GRUB_SOURCE))
	@$(call patchin, $(GRUB))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

grub_prepare: $(STATEDIR)/grub.prepare

GRUB_PATH	= PATH=$(CROSS_PATH)

# RSC: grub 0.93 decides to build without optimization when it detects
# non-standard CFLAGS. We can unset them here as grub is compiled
# standalone anyway (without Linux/glibc includes)

GRUB_ENV	= $(CROSS_ENV) CFLAGS=''

GRUB_AUTOCONF =  $(CROSS_AUTOCONF_USR)
GRUB_AUTOCONF += --target=$(PTXCONF_GNU_TARGET)
# FIXME FIXME FIXME
GRUB_AUTOCONF += --prefix=$(PTXCONF_PREFIX)

ifneq ("", "$(PTXCONF_GRUB_PRESET_MENU)")
GRUB_AUTOCONF += --enable-preset-menu=$(PTXCONF_GRUB_PRESET_MENU)
else
GRUB_AUTOCONF += --disable-preset-menu
endif
ifeq (y, $(PTXCONF_GRUB_FFS))
GRUB_AUTOCONF += --enable-ffs
else
GRUB_AUTOCONF += --disable-ffs
endif
ifeq (y, $(PTXCONF_GRUB_MINIXFS))
GRUB_AUTOCONF += --enable-minix
else
GRUB_AUTOCONF += --disable-minix
endif
ifeq (y, $(PTXCONF_GRUB_REISERFS))
GRUB_AUTOCONF += --enable-reiserfs
else
GRUB_AUTOCONF += --disable-reiserfs
endif
ifeq (y, $(PTXCONF_GRUB_VFTAFS))
GRUB_AUTOCONF += --enable-vstafs
else
GRUB_AUTOCONF += --disable-vstafs
endif
ifeq (y, $(PTXCONF_GRUB_JFS))
GRUB_AUTOCONF += --enable-jfs
else
GRUB_AUTOCONF += --disable-jfs
endif
ifeq (y, $(PTXCONF_GRUB_XFS))
GRUB_AUTOCONF += --enable-xfs
else
GRUB_AUTOCONF += --disable-xfs
endif
ifeq (y, $(PTXCONF_GRUB_MD5))
GRUB_AUTOCONF += --enable-md5-password
else
GRUB_AUTOCONF += --disable-md5-password
endif
ifeq (y, $(PTXCONF_GRUB_CS89X0))
GRUB_AUTOCONF += --enable-cs89x0
else
GRUB_AUTOCONF += --disable-cs89x0
endif
ifeq (y, $(PTXCONF_GRUB_EEPRO100))
GRUB_AUTOCONF += --enable-eepro100
else
GRUB_AUTOCONF += --disable-eepro100
endif
ifeq (y, $(PTXCONF_GRUB_RTL8139))
GRUB_AUTOCONF += --enable-rtl8139
else
GRUB_AUTOCONF += --disable-rtl8139
endif

$(STATEDIR)/grub.prepare: $(grub_prepare_deps_default)
	@$(call targetinfo, $@)
	cd $(GRUB_DIR) && \
		$(GRUB_PATH) $(GRUB_ENV) ./configure $(GRUB_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

grub_compile: $(STATEDIR)/grub.compile

$(STATEDIR)/grub.compile: $(grub_compile_deps_default)
	@$(call targetinfo, $@)
	$(GRUB_PATH) make -C $(GRUB_DIR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

grub_install: $(STATEDIR)/grub.install

$(STATEDIR)/grub.install: $(grub_install_deps_default)
	@$(call targetinfo, $@)
#	make -C $(GRUB_DIR) install
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

grub_targetinstall: $(STATEDIR)/grub.targetinstall

$(STATEDIR)/grub.targetinstall: $(grub_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, grub)
	@$(call install_fixup, grub,PACKAGE,grub)
	@$(call install_fixup, grub,PRIORITY,optional)
	@$(call install_fixup, grub,VERSION,$(GRUB_VERSION))
	@$(call install_fixup, grub,SECTION,base)
	@$(call install_fixup, grub,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, grub,DEPENDS,)
	@$(call install_fixup, grub,DESCRIPTION,missing)

	@$(call install_copy, grub, 0, 0, 0644, $(GRUB_DIR)/stage1/stage1, /boot/grub/stage1)
	@$(call install_copy, grub, 0, 0, 0644, $(GRUB_DIR)/stage2/stage2, /boot/grub/stage2)
	@$(call install_copy, grub, 0, 0, 0755, $(GRUB_DIR)/grub/grub, /usr/sbin/grub)

	@$(call install_finish, grub)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

grub_clean: 
	rm -rf $(STATEDIR)/grub.* 
	rm -rf $(IMAGEDIR)/grub_* 
	rm -rf $(GRUB_DIR)

# vim: syntax=make
