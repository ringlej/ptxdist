# -*-makefile-*-
# $Id: xchain-binutils.make,v 1.4 2003/06/16 12:05:16 bsp Exp $
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
ifeq (y,$(PTXCONF_BUILD_CROSSCHAIN))
PACKAGES += xchain-binutils
endif

#
# Paths and names 
#
BINUTILS		= binutils-2.11.2
BINUTILS_URL		= ftp://ftp.gnu.org/pub/gnu/binutils/$(BINUTILS).tar.gz
BINUTILS_SOURCE		= $(SRCDIR)/$(BINUTILS).tar.gz
BINUTILS_DIR		= $(BUILDDIR)/$(BINUTILS)
BINUTILS_EXTRACT 	= gzip -dc

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xchain-binutils_get: $(STATEDIR)/xchain-binutils.get

$(STATEDIR)/xchain-binutils.get: $(BINUTILS_SOURCE)
	touch $@

$(BINUTILS_SOURCE):
	@$(call targetinfo, xchain-binutils.get)
	wget -P $(SRCDIR) $(PASSIVEFTP) $(BINUTILS_URL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xchain-binutils_extract: $(STATEDIR)/xchain-binutils.extract

$(STATEDIR)/xchain-binutils.extract: $(STATEDIR)/xchain-binutils.get
	@$(call targetinfo, xchain-binutils.extract)
	$(BINUTILS_EXTRACT) $(BINUTILS_SOURCE) | $(TAR) -C $(BUILDDIR) -xf -
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xchain-binutils_prepare: $(STATEDIR)/xchain-binutils.prepare

$(STATEDIR)/xchain-binutils.prepare: $(STATEDIR)/xchain-binutils.extract
	@$(call targetinfo, xchain-binutils.prepare)
	cd $(BINUTILS_DIR) && 						\
	./configure 							\
		--disable-shared					\
		--target=$(PTXCONF_GNU_TARGET)				\
		--prefix=$(PTXCONF_PREFIX) 			\
		--enable-targets=$(PTXCONF_GNU_TARGET)	
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xchain-binutils_compile: $(STATEDIR)/xchain-binutils.compile

$(STATEDIR)/xchain-binutils.compile: $(STATEDIR)/xchain-binutils.prepare 
	@$(call targetinfo, xchain-binutils.compile)
	cd $(BINUTILS_DIR) && make 
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-binutils_install: $(STATEDIR)/xchain-binutils.install

$(STATEDIR)/xchain-binutils.install: $(STATEDIR)/xchain-binutils.compile
	@$(call targetinfo, xchain-binutils.install)
#	[ -d $(PTXCONF_PREFIX) ] || 					\
#		$(SUDO) install -g users -m 0755 			\
#				-o $(PTXUSER) 				\
#				-d $(PTXCONF_PREFIX)
	cd $(BINUTILS_DIR) && make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xchain-binutils_targetinstall: $(STATEDIR)/xchain-binutils.targetinstall

$(STATEDIR)/xchain-binutils.targetinstall: $(STATEDIR)/xchain-binutils.install
	@$(call targetinfo, xchain-binutils.targetinstall)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xchain-binutils_clean: 
	rm -rf $(STATEDIR)/xchain-binutils.* $(BINUTILS_DIR)

# vim: syntax=make
