# -*-makefile-*-
# $Id: grub.make,v 1.10 2004/01/27 18:34:53 robert Exp $
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
ifeq (y, $(PTXCONF_GRUB))
PACKAGES += grub
endif

#
# Paths and names 
#
GRUB			= grub-0.93
GRUB_URL		= ftp://alpha.gnu.org/gnu/grub/$(GRUB).tar.gz
GRUB_SOURCE		= $(SRCDIR)/$(GRUB).tar.gz
GRUB_DIR		= $(BUILDDIR)/$(GRUB)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

grub_get: $(STATEDIR)/grub.get

$(STATEDIR)/grub.get: $(GRUB_SOURCE)
	@$(call targetinfo, $@)
	@$(call get_patches, $(GRUB))
	touch $@

$(GRUB_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(GRUB_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

grub_extract: $(STATEDIR)/grub.extract

$(STATEDIR)/grub.extract: $(STATEDIR)/grub.get
	@$(call targetinfo, $@)
	@$(call clean, $(GRUB_DIR))
	@$(call extract, $(GRUB_SOURCE))
	@$(call patchin, $(GRUB))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

grub_prepare: $(STATEDIR)/grub.prepare

GRUB_PATH	= PATH=$(CROSS_PATH)

# RSC: grub 0.93 decides to build without optimization when it detects
# non-standard CFLAGS. We can unset them here as grub is compiled
# standalone anyway (without Linux/glibc includes)

GRUB_ENV	= $(CROSS_ENV) CFLAGS=''

GRUB_AUTOCONF =  --build=$(GNU_HOST)
GRUB_AUTOCONF += --host=$(PTXCONF_GNU_TARGET)
GRUB_AUTOCONF += --target=$(PTXCONF_GNU_TARGET)

GRUB_AUTOCONF +=  --prefix=$(PTXCONF_PREFIX)
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

grub_prepare_deps = \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/grub.extract

$(STATEDIR)/grub.prepare: $(grub_prepare_deps)
	@$(call targetinfo, $@)
	cd $(GRUB_DIR) && \
		$(GRUB_PATH) $(GRUB_ENV) ./configure $(GRUB_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

grub_compile: $(STATEDIR)/grub.compile

$(STATEDIR)/grub.compile: $(STATEDIR)/grub.prepare 
	@$(call targetinfo, $@)
	$(GRUB_PATH) make -C $(GRUB_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

grub_install: $(STATEDIR)/grub.install

$(STATEDIR)/grub.install: $(STATEDIR)/grub.compile
	@$(call targetinfo, $@)
#	make -C $(GRUB_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

grub_targetinstall: $(STATEDIR)/grub.targetinstall

$(STATEDIR)/grub.targetinstall: $(STATEDIR)/grub.install
	@$(call targetinfo, $@)
	mkdir -p $(ROOTDIR)/boot/grub
	install $(GRUB_DIR)/stage1/stage1 $(ROOTDIR)/boot/grub/
	install $(GRUB_DIR)/stage2/stage2 $(ROOTDIR)/boot/grub/
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

grub_clean: 
	rm -rf $(STATEDIR)/grub.* $(GRUB_DIR)

# vim: syntax=make
