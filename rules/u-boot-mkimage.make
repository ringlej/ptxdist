# $Id: u-boot-mkimage.make,v 1.1 2003/04/24 08:06:33 jst Exp $
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
PACKAGES += umkimage

#
# Paths and names 
#
UMKIMAGE			= u-boot-mkimage-20030314
UMKIMAGE_URL			= http://www.pengutronix.de/software/ptxdist/temporary-src/$(UMKIMAGE).tar.gz
UMKIMAGE_SOURCE			= $(SRCDIR)/$(UMKIMAGE).tar.gz
UMKIMAGE_DIR			= $(BUILDDIR)/$(UMKIMAGE)
UMKIMAGE_EXTRACT 		= gzip -dc

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

umkimage_get: $(STATEDIR)/umkimage.get

$(STATEDIR)/umkimage.get: $(UMKIMAGE_SOURCE)
	touch $@

$(UMKIMAGE_SOURCE):
	@echo
	@echo -------------------- 
	@echo target: umkimage.get
	@echo --------------------
	@echo
	wget -P $(SRCDIR) $(PASSIVEFTP) $(UMKIMAGE_URL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

umkimage_extract: $(STATEDIR)/umkimage.extract

$(STATEDIR)/umkimage.extract: $(STATEDIR)/umkimage.get
	@echo
	@echo ------------------------ 
	@echo target: umkimage.extract
	@echo ------------------------
	@echo
	$(UMKIMAGE_EXTRACT) $(UMKIMAGE_SOURCE) | $(TAR) -C $(BUILDDIR) -xf -
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

umkimage_prepare: $(STATEDIR)/umkimage.prepare

$(STATEDIR)/umkimage.prepare: $(STATEDIR)/umkimage.extract
	@echo
	@echo ------------------------ 
	@echo target: umkimage.prepare
	@echo ------------------------
	@echo
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

umkimage_compile: $(STATEDIR)/umkimage.compile

$(STATEDIR)/umkimage.compile: $(STATEDIR)/umkimage.prepare 
	@echo
	@echo ------------------------ 
	@echo target: umkimage.compile
	@echo ------------------------
	@echo
	make -C $(UMKIMAGE_DIR) 
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

umkimage_install: $(STATEDIR)/umkimage.install

$(STATEDIR)/umkimage.install: $(STATEDIR)/umkimage.compile
	@echo
	@echo ------------------------ 
	@echo target: umkimage.install
	@echo ------------------------
	@echo
	install $(UMKIMAGE_DIR)/mkimage $(PTXCONF_PREFIX)/bin/u-boot-mkimage
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

umkimage_targetinstall: $(STATEDIR)/umkimage.targetinstall

$(STATEDIR)/umkimage.targetinstall: $(STATEDIR)/umkimage.install
	@echo
	@echo ----------------------- 
	@echo target: umkimage.targetinstall
	@echo -----------------------
	@echo
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

umkimage_clean: 
	rm -rf $(STATEDIR)/umkimage.* $(UMKIMAGE_DIR)

# vim: syntax=make
