# $Id: mtd.make,v 1.2 2003/06/16 12:05:16 bsp Exp $
#
# (c) 2003 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

#
# We provide this package
#

ifeq (y, $(PTXCONF_KERNEL_MTD))
PACKAGES += mtd
endif

ifeq (y, $(PTXCONF_MTD_UTILS))
PACKAGES += mtdutil
endif

#
# Paths and names 
#
MTD			= mtd-20030301-1
MTD_URL			= http://www.pengutronix.de/software/ptxdist/temporary-src/$(MTD).tar.gz
MTD_SOURCE		= $(SRCDIR)/$(MTD).tar.gz
MTD_DIR			= $(BUILDDIR)/$(MTD)
MTD_EXTRACT 		= gzip -dc

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

mtd_get: $(STATEDIR)/mtd.get

$(STATEDIR)/mtd.get: $(MTD_SOURCE)
	touch $@

mtdutil_get: $(STATEDIR)/mtdutil.get

$(STATEDIR)/mtdutil.get: $(MTD_SOURCE)
	@$(call targetinfo, mtdutil.get)
	touch $@

$(MTD_SOURCE):
	@$(call targetinfo, mtd.get)
	wget -P $(SRCDIR) $(PASSIVEFTP) $(MTD_URL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

mtd_extract: $(STATEDIR)/mtd.extract

$(STATEDIR)/mtd.extract: $(STATEDIR)/mtd.get
	@$(call targetinfo, mtd.extract)
	$(MTD_EXTRACT) $(MTD_SOURCE) | $(TAR) -C $(BUILDDIR) -xf -
	touch $@

mtdutil_extract: $(STATEDIR)/mtdutil.extract

$(STATEDIR)/mtdutil.extract: $(STATEDIR)/mtdutil.get
	@$(call targetinfo, mtdutil.extract)
	rm -fr $(BUILDDIR)/mtdutil
	mkdir -p $(BUILDDIR)/mtdutil
	$(MTD_EXTRACT) $(MTD_SOURCE) | $(TAR) -C $(BUILDDIR)/mtdutil -xf - $(MTD)/util
	$(MTD_EXTRACT) $(MTD_SOURCE) | $(TAR) -C $(BUILDDIR)/mtdutil -xf - $(MTD)/fs
	$(MTD_EXTRACT) $(MTD_SOURCE) | $(TAR) -C $(BUILDDIR)/mtdutil -xf - $(MTD)/include
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

mtd_prepare: $(STATEDIR)/mtd.prepare

$(STATEDIR)/mtd.prepare: $(STATEDIR)/mtd.extract
	@$(call targetinfo, mtd.prepare)
	# Makefile is currently fucked up... @#*$
	# FIXME: patch sent to maintainer, remove this for fixed version 
	perl -i -p -e 's/\(CFLAGS\) -o/\(LDFLAGS\) -o/g'  $(MTD_DIR)/util/Makefile
	perl -i -p -e 's/^CFLAGS \+\=/override CFLAGS +=/g' $(MTD_DIR)/util/Makefile
	touch $@

mtdutil_prepare: $(STATEDIR)/mtdutil.prepare

$(STATEDIR)/mtdutil.prepare: $(STATEDIR)/mtdutil.extract
	@$(call targetinfo, mtdutil.prepare)
	# Makefile is currently fucked up... @#*$
	# FIXME: patch sent to maintainer, remove this for fixed version 
	perl -i -p -e 's/\(CFLAGS\) -o/\(LDFLAGS\) -o/g'  $(BUILDDIR)/mtdutil/$(MTD)/util/Makefile
	perl -i -p -e 's/^CFLAGS \+\=/override CFLAGS +=/g' $(BUILDDIR)/mtdutil/$(MTD)/util/Makefile
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

mtd_compile: $(STATEDIR)/mtd.compile

MTD_ENVIRONMENT		=
MTD_MAKEVARS		=  CFLAGS=-I$(PTXCONF_PREFIX)/include
MTD_MAKEVARS		+= LDFLAGS=-L$(PTXCONF_PREFIX)/lib

$(STATEDIR)/mtd.compile: $(STATEDIR)/mtd.prepare $(STATEDIR)/xchain-zlib.install
	@$(call targetinfo, mtd.compile)
	$(MTD_ENVIRONMENT) make -C $(MTD_DIR)/util mkfs.jffs mkfs.jffs2 $(MTD_MAKEVARS) 
	touch $@


mtdutil_compile_deps =  $(STATEDIR)/mtdutil.prepare 
mtdutil_compile_deps += $(STATEDIR)/zlib.install

MTD-UTIL_ENVIRONMENT	= 
MTD-UTIL_MAKEVARS	=
MTD-UTIL_ENVIRONMENT	+= PATH=$(PTXCONF_PREFIX)/bin:$$PATH
MTD-UTIL_MAKEVARS	+= CROSS=$(PTXCONF_GNU_TARGET)-
MTD-UTIL_MAKEVARS	+= CFLAGS=-I$(PTXCONF_PREFIX)/include
MTD-UTIL_MAKEVARS 	+= LDFLAGS=-L$(ZLIB_DIR)

mtdutil_compile: $(STATEDIR)/mtdutil.compile

$(STATEDIR)/mtdutil.compile: $(mtdutil_compile_deps) 
	@$(call targetinfo, mtdutil.compile)
	$(MTD-UTIL_ENVIRONMENT) make -C $(BUILDDIR)/mtdutil/$(MTD)/util $(MTD-UTIL_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

mtd_install: $(STATEDIR)/mtd.install

$(STATEDIR)/mtd.install: $(STATEDIR)/mtd.compile
	@$(call targetinfo, mtd.install)
	install $(MTD_DIR)/util/mkfs.jffs $(PTXCONF_PREFIX)/bin
	install $(MTD_DIR)/util/mkfs.jffs2 $(PTXCONF_PREFIX)/bin
	touch $@

mtdutil_install: $(STATEDIR)/mtdutil.install

$(STATEDIR)/mtdutil.install: $(STATEDIR)/mtdutil.compile
	@$(call targetinfo, mtdutil.install)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

mtd_targetinstall: $(STATEDIR)/mtd.targetinstall

$(STATEDIR)/mtd.targetinstall: $(STATEDIR)/mtd.install
	@$(call targetinfo, mtd.targetinstall)
	touch $@

mtdutil_targetinstall: $(STATEDIR)/mtdutil.targetinstall

$(STATEDIR)/mtdutil.targetinstall: $(STATEDIR)/mtdutil.install
	@$(call targetinfo, mtdutil.targetinstall)
        ifeq (y, $(PTXCONF_MTD_EINFO))
	install $(BUILDDIR)/mtdutil/$(MTD)/util/einfo $(ROOTDIR)/sbin
	$(CROSSSTRIP) -S $(ROOTDIR)/sbin/einfo
        endif
        ifeq (y, $(PTXCONF_MTD_ERASE))
	install $(BUILDDIR)/mtdutil/$(MTD)/util/erase $(ROOTDIR)/sbin
	$(CROSSSTRIP) -S $(ROOTDIR)/sbin/erase
        endif
        ifeq (y, $(PTXCONF_MTD_ERASEALL))
	install $(BUILDDIR)/mtdutil/$(MTD)/util/eraseall $(ROOTDIR)/sbin
	$(CROSSSTRIP) -S $(ROOTDIR)/sbin/eraseall
        endif
        ifeq (y, $(PTXCONF_MTD_FCP))
	install $(BUILDDIR)/mtdutil/$(MTD)/util/fcp $(ROOTDIR)/sbin
	$(CROSSSTRIP) -S $(ROOTDIR)/sbin/fcp
        endif 
        ifeq (y, $(PTXCONF_MTD_FTL_CHECK))
	install $(BUILDDIR)/mtdutil/$(MTD)/util/ftl_check $(ROOTDIR)/sbin
	$(CROSSSTRIP) -S $(ROOTDIR)/sbin/check
        endif 
        ifeq (y, $(PTXCONF_MTD_FTL_FORMAT))
	install $(BUILDDIR)/mtdutil/$(MTD)/util/ftl_format $(ROOTDIR)/sbin
	$(CROSSSTRIP) -S $(ROOTDIR)/sbin/ftl_format
        endif 
        ifeq (y, $(PTXCONF_MTD_JFFS2READER))
	install $(BUILDDIR)/mtdutil/$(MTD)/util/jffs2reader $(ROOTDIR)/sbin
	$(CROSSSTRIP) -S $(ROOTDIR)/sbin/jffs2reader
        endif 
        ifeq (y, $(PTXCONF_MTD_LOCK))
	install $(BUILDDIR)/mtdutil/$(MTD)/util/lock $(ROOTDIR)/sbin
	$(CROSSSTRIP) -S $(ROOTDIR)/sbin/lock
        endif 
        ifeq (y, $(PTXCONF_MTD_MTDDEBUG))
	install $(BUILDDIR)/mtdutil/$(MTD)/util/mtd_debug $(ROOTDIR)/sbin
	$(CROSSSTRIP) -S $(ROOTDIR)/sbin/mtd_debug
        endif 
        ifeq (y, $(PTXCONF_MTD_NANDDUMP))
	install $(BUILDDIR)/mtdutil/$(MTD)/util/nanddump $(ROOTDIR)/sbin
	$(CROSSSTRIP) -S $(ROOTDIR)/sbin/nanddump
        endif 
        ifeq (y, $(PTXCONF_MTD_NANDTEST))
	install $(BUILDDIR)/mtdutil/$(MTD)/util/nandtest $(ROOTDIR)/sbin
	$(CROSSSTRIP) -S $(ROOTDIR)/sbin/nandtest
        endif 
        ifeq (y, $(PTXCONF_MTD_NANDWRITE))
	install $(BUILDDIR)/mtdutil/$(MTD)/util/nandwrite $(ROOTDIR)/sbin
	$(CROSSSTRIP) -S $(ROOTDIR)/sbin/nandwrite
        endif 
        ifeq (y, $(PTXCONF_MTD_NFTL_FORMAT))
	install $(BUILDDIR)/mtdutil/$(MTD)/util/nftl_format $(ROOTDIR)/sbin
	$(CROSSSTRIP) -S $(ROOTDIR)/sbin/nftl_format
        endif 
        ifeq (y, $(PTXCONF_MTD_NFTLDUMP))
	install $(BUILDDIR)/mtdutil/$(MTD)/util/nftldump $(ROOTDIR)/sbin
	$(CROSSSTRIP) -S $(ROOTDIR)/sbin/nftldump
        endif 
        ifeq (y, $(PTXCONF_MTD_UNLOCK))
	install $(BUILDDIR)/mtdutil/$(MTD)/util/unlock $(ROOTDIR)/sbin
	$(CROSSSTRIP) -S $(ROOTDIR)/sbin/unlock
        endif 
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

mtd_clean: 
	rm -rf $(STATEDIR)/mtd.* $(MTD_DIR)

mtdutil_clean:
	rm -fr $(STATEDIR)/mtdutil.* $(BUILDDIR)/mtdutil

# vim: syntax=make
