# $Id: xchain-binutils.make,v 1.1 2003/04/24 08:06:33 jst Exp $
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
	@echo
	@echo ------------------- 
	@echo target: xchain-binutils.get
	@echo -------------------
	@echo
	wget -P $(SRCDIR) $(PASSIVEFTP) $(BINUTILS_URL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xchain-binutils_extract: $(STATEDIR)/xchain-binutils.extract

$(STATEDIR)/xchain-binutils.extract: $(STATEDIR)/xchain-binutils.get
	@echo
	@echo ----------------------- 
	@echo target: xchain-binutils.extract
	@echo -----------------------
	@echo
	$(BINUTILS_EXTRACT) $(BINUTILS_SOURCE) | $(TAR) -C $(BUILDDIR) -xf -
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xchain-binutils_prepare: $(STATEDIR)/xchain-binutils.prepare

$(STATEDIR)/xchain-binutils.prepare: $(STATEDIR)/xchain-binutils.extract
	@echo
	@echo ----------------------- 
	@echo target: xchain-binutils.prepare
	@echo -----------------------
	@echo
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
	@echo
	@echo ----------------------- 
	@echo target: xchain-binutils.compile
	@echo -----------------------
	@echo
	cd $(BINUTILS_DIR) && make 
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-binutils_install: $(STATEDIR)/xchain-binutils.install

$(STATEDIR)/xchain-binutils.install: $(STATEDIR)/xchain-binutils.compile
	@echo
	@echo ----------------------- 
	@echo target: xchain-binutils.install
	@echo -----------------------
	@echo
	[ -d $(PTXCONF_PREFIX) ] || 					\
		$(SUDO) install -g users -m 0755 			\
				-o $(PTXUSER) 				\
				-d $(PTXCONF_PREFIX)
	cd $(BINUTILS_DIR) && make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xchain-binutils_targetinstall: $(STATEDIR)/xchain-binutils.targetinstall

$(STATEDIR)/xchain-binutils.targetinstall: $(STATEDIR)/xchain-binutils.install
	@echo
	@echo ----------------------------- 
	@echo target: xchain-binutils.targetinstall
	@echo -----------------------------
	@echo
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xchain-binutils_clean: 
	rm -rf $(STATEDIR)/xchain-binutils.* $(BINUTILS_DIR)

# vim: syntax=make
