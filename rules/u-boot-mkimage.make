# -*-makefile-*-
# $Id: u-boot-mkimage.make,v 1.6 2003/08/29 01:42:32 mkl Exp $
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
# PACKAGES += umkimage

#
# Paths and names 
#
UMKIMAGE			= u-boot-mkimage-20030424
UMKIMAGE_URL			= http://www.pengutronix.de/software/ptxdist/temporary-src/$(UMKIMAGE).tar.gz
UMKIMAGE_SOURCE			= $(SRCDIR)/$(UMKIMAGE).tar.gz
UMKIMAGE_DIR			= $(BUILDDIR)/$(UMKIMAGE)
UMKIMAGE_EXTRACT 		= gzip -dc

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

umkimage_get: $(STATEDIR)/umkimage.get

$(STATEDIR)/umkimage.get: $(UMKIMAGE_SOURCE)
	@$(call targetinfo, umkimage.get)
	touch $@

$(UMKIMAGE_SOURCE):
	@$(call targetinfo, $(UMKIMAGE_SOURCE))
	wget -P $(SRCDIR) $(PASSIVEFTP) $(UMKIMAGE_URL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

umkimage_extract: $(STATEDIR)/umkimage.extract

$(STATEDIR)/umkimage.extract: $(STATEDIR)/umkimage.get
	@$(call targetinfo, umkimage.extract)
	$(UMKIMAGE_EXTRACT) $(UMKIMAGE_SOURCE) | $(TAR) -C $(BUILDDIR) -xf -
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

umkimage_prepare: $(STATEDIR)/umkimage.prepare

umkimage_prepare_deps = \
	$(STATEDIR)/umkimage.extract \
	$(STATEDIR)/xchain-zlib.install

$(STATEDIR)/umkimage.prepare: $(umkimage_prepare_deps)
	@$(call targetinfo, umkimage.prepare)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

umkimage_compile: $(STATEDIR)/umkimage.compile

$(STATEDIR)/umkimage.compile: $(STATEDIR)/umkimage.prepare 
	@$(call targetinfo, umkimage.compile)
	# FIXME: no spaces in pathnames:
	CC=$(HOSTCC) CFLAGS=-I$(PTXCONF_PREFIX)/include LIBS=-L$(PTXCONF_PREFIX)/lib make -C $(UMKIMAGE_DIR) 
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

umkimage_install: $(STATEDIR)/umkimage.install

$(STATEDIR)/umkimage.install: $(STATEDIR)/umkimage.compile
	@$(call targetinfo, umkimage.install)
	install $(UMKIMAGE_DIR)/mkimage $(PTXCONF_PREFIX)/bin/u-boot-mkimage
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

umkimage_targetinstall: $(STATEDIR)/umkimage.targetinstall

$(STATEDIR)/umkimage.targetinstall: $(STATEDIR)/umkimage.install
	@$(call targetinfo, umkimage.targetinstall)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

umkimage_clean: 
	rm -rf $(STATEDIR)/umkimage.* $(UMKIMAGE_DIR)

# vim: syntax=make
