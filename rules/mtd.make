# -*-makefile-*-
# $Id: mtd.make,v 1.11 2004/02/04 22:48:52 robert Exp $
#
# Copyright (C) 2003 by Pengutronix e.K., Hildesheim, Germany
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_MTD_UTILS
PACKAGES += mtd
endif

#
# Paths and names
#
MTD_VERSION	= 20030301-1
MTD		= mtd-$(MTD_VERSION)
MTD_SUFFIX	= tar.gz
MTD_URL		= http://www.pengutronix.de/software/ptxdist/temporary-src/$(MTD).$(MTD_SUFFIX)
MTD_SOURCE	= $(SRCDIR)/$(MTD).$(MTD_SUFFIX)
MTD_DIR		= $(BUILDDIR)/$(MTD)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

mtd_get: $(STATEDIR)/mtd.get

mtd_get_deps = $(MTD_SOURCE)

$(STATEDIR)/mtd.get: $(mtd_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(MTD))
	touch $@

$(MTD_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(MTD_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

mtd_extract: $(STATEDIR)/mtd.extract

mtd_extract_deps = $(STATEDIR)/mtd.get

$(STATEDIR)/mtd.extract: $(mtd_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(MTD_DIR))
	@$(call extract, $(MTD_SOURCE))
	@$(call patchin, $(MTD))
#
# Makefile is currently fucked up... @#*$
# FIXME: patch sent to maintainer, remove this for fixed version
#
	perl -i -p -e 's/\(CFLAGS\) -o/\(LDFLAGS\) -o/g' $(MTD_DIR)/util/Makefile
	perl -i -p -e 's/^CFLAGS \+\=/override CFLAGS +=/g' $(MTD_DIR)/util/Makefile
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

mtd_prepare: $(STATEDIR)/mtd.prepare

#
# dependencies
#
mtd_prepare_deps = \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/zlib.install \
	$(STATEDIR)/mtd.extract

MTD_PATH	= PATH=$(CROSS_PATH)
MTD_MAKEVARS	= CROSS=$(PTXCONF_GNU_TARGET)-
MTD_ENV		= $(CROSS_ENV)

$(STATEDIR)/mtd.prepare: $(mtd_prepare_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

mtd_compile: $(STATEDIR)/mtd.compile

mtd_compile_deps = $(STATEDIR)/mtd.prepare

$(STATEDIR)/mtd.compile: $(mtd_compile_deps)
	@$(call targetinfo, $@)
	$(MTD_ENV) $(MTD_PATH) make -C $(MTD_DIR)/util $(MTD_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

mtd_install: $(STATEDIR)/mtd.install

$(STATEDIR)/mtd.install: $(STATEDIR)/mtd.compile
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

mtd_targetinstall: $(STATEDIR)/mtd.targetinstall

mtd_targetinstall_deps	=  $(STATEDIR)/mtd.compile
ifdef PTXCONF_MTD_MKJFFS
mtd_targetinstall_deps	+= $(STATEDIR)/zlib.targetinstall
endif
ifdef PTXCONF_MTD_MKJFFS2
mtd_targetinstall_deps	+= $(STATEDIR)/zlib.targetinstall
endif

$(STATEDIR)/mtd.targetinstall: $(mtd_targetinstall_deps)
	@$(call targetinfo, $@)
	install -d $(ROOTDIR)/sbin

ifdef PTXCONF_MTD_EINFO
	install $(BUILDDIR)/$(MTD)/util/einfo $(ROOTDIR)/sbin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/einfo
endif
ifdef PTXCONF_MTD_ERASE
	install $(BUILDDIR)/$(MTD)/util/erase $(ROOTDIR)/sbin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/erase
endif
ifdef PTXCONF_MTD_ERASEALL
	install $(BUILDDIR)/$(MTD)/util/eraseall $(ROOTDIR)/sbin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/eraseall
endif
ifdef PTXCONF_MTD_FCP
	install $(BUILDDIR)/$(MTD)/util/fcp $(ROOTDIR)/sbin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/fcp
endif
ifdef PTXCONF_MTD_FTL_CHECK
	install $(BUILDDIR)/$(MTD)/util/ftl_check $(ROOTDIR)/sbin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/check
endif
ifdef PTXCONF_MTD_FTL_FORMAT
	install $(BUILDDIR)/$(MTD)/util/ftl_format $(ROOTDIR)/sbin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/ftl_format
endif
ifdef PTXCONF_MTD_JFFS2READER
	install $(BUILDDIR)/$(MTD)/util/jffs2reader $(ROOTDIR)/sbin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/jffs2reader
endif
ifdef PTXCONF_MTD_LOCK
	install $(BUILDDIR)/$(MTD)/util/lock $(ROOTDIR)/sbin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/lock
endif
ifdef PTXCONF_MTD_MTDDEBUG
	install $(BUILDDIR)/$(MTD)/util/mtd_debug $(ROOTDIR)/sbin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/mtd_debug
endif
ifdef PTXCONF_MTD_NANDDUMP
	install $(BUILDDIR)/$(MTD)/util/nanddump $(ROOTDIR)/sbin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/nanddump
endif
ifdef PTXCONF_MTD_NANDTEST
	install $(BUILDDIR)/$(MTD)/util/nandtest $(ROOTDIR)/sbin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/nandtest
endif
ifdef PTXCONF_MTD_NANDWRITE
	install $(BUILDDIR)/$(MTD)/util/nandwrite $(ROOTDIR)/sbin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/nandwrite
endif
ifdef PTXCONF_MTD_NFTL_FORMAT
	install $(BUILDDIR)/$(MTD)/util/nftl_format $(ROOTDIR)/sbin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/nftl_format
endif
ifdef PTXCONF_MTD_NFTLDUMP
	install $(BUILDDIR)/$(MTD)/util/nftldump $(ROOTDIR)/sbin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/nftldump
endif
ifdef PTXCONF_MTD_UNLOCK
	install $(BUILDDIR)/$(MTD)/util/unlock $(ROOTDIR)/sbin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/unlock
endif
ifdef PTXCONF_MTD_MKJFFS
	install $(BUILDDIR)/$(MTD)/util/mkfs.jffs $(ROOTDIR)/sbin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/mkfs.jffs
endif
ifdef PTXCONF_MTD_MKJFFS2
	install $(BUILDDIR)/$(MTD)/util/mkfs.jffs2 $(ROOTDIR)/sbin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/mkfs.jffs2
endif
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

mtd_clean:
	rm -rf $(STATEDIR)/mtd.*
	rm -rf $(MTD_DIR)

# vim: syntax=make
