# -*-makefile-*-
# $Id: grub.make,v 1.2 2003/05/13 11:19:44 robert Exp $
#
# (c) 2002 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXDIST project and license conditions
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
GRUB			= grub-0.92
GRUB_URL		= http://www.gnu.org/software/grub/$(GRUB).tar.gz
GRUB_SOURCE		= $(SRCDIR)/$(GRUB).tar.gz
GRUB_DIR		= $(BUILDDIR)/$(GRUB)
GRUB_EXTRACT 		= gzip -dc

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

grub_get: $(STATEDIR)/grub.get

$(STATEDIR)/grub.get: $(GRUB_SOURCE)
	touch $@

$(GRUB_SOURCE):
	@echo
	@echo ---------------- 
	@echo target: grub.get
	@echo ----------------
	@echo
	wget -P $(SRCDIR) $(PASSIVEFTP) $(GRUB_URL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

grub_extract: $(STATEDIR)/grub.extract

$(STATEDIR)/grub.extract: $(STATEDIR)/grub.get
	@echo
	@echo --------------------
	@echo target: grub.extract
	@echo --------------------
	@echo
	$(GRUB_EXTRACT) $(GRUB_SOURCE) | $(TAR) -C $(BUILDDIR) -xf -
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

grub_prepare: $(STATEDIR)/grub.prepare

GRUB_AUTOCONF =  --prefix=$(PTXCONF_PREFIX)
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

$(STATEDIR)/grub.prepare: $(STATEDIR)/grub.extract
	@echo
	@echo --------------------
	@echo target: grub.prepare
	@echo --------------------
	@echo
	cd $(GRUB_DIR) && ./configure $(GRUB_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

grub_compile: $(STATEDIR)/grub.compile

$(STATEDIR)/grub.compile: $(STATEDIR)/grub.prepare 
	@echo
	@echo --------------------
	@echo target: grub.compile
	@echo --------------------
	@echo
	make -C $(GRUB_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

grub_install: $(STATEDIR)/grub.install

$(STATEDIR)/grub.install: $(STATEDIR)/grub.compile
	@echo
	@echo --------------------
	@echo target: grub.install
	@echo --------------------
	@echo
#	make -C $(GRUB_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

grub_targetinstall: $(STATEDIR)/grub.targetinstall

$(STATEDIR)/grub.targetinstall: $(STATEDIR)/grub.install
	@echo
	@echo --------------------------
	@echo target: grub.targetinstall
	@echo --------------------------
	@echo
	mkdir -p $(ROOTDIR)/boot/grub
	install $(GRUB_DIR)/stage1/stage1 $(ROOTDIR)/boot/grub/
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

grub_clean: 
	rm -rf $(STATEDIR)/grub.* $(GRUB_DIR)

# vim: syntax=make
