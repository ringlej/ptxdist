# $Id: proftpd.make,v 1.1 2003/04/24 08:06:33 jst Exp $
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
ifeq (y, $(PTXCONF_PROFTPD))
PACKAGES += proftpd
endif

#
# Paths and names 
#
PROFTPD_VERSION 	= 1.2.6
PROFTPD			= proftpd-$(PROFTPD_VERSION)
PROFTPD_URL		= ftp://ftp.proftpd.org/distrib/source/$(PROFTPD).tar.gz
PROFTPD_SOURCE		= $(SRCDIR)/$(PROFTPD).tar.gz
PROFTPD_DIR		= $(BUILDDIR)/$(PROFTPD)
PROFTPD_EXTRACT 	= gzip -dc

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

proftpd_get: $(STATEDIR)/proftpd.get

$(STATEDIR)/proftpd.get: $(PROFTPD_SOURCE)
	touch $@

$(PROFTPD_SOURCE):
	@echo
	@echo ------------------- 
	@echo target: proftpd.get
	@echo -------------------
	@echo
	wget -P $(SRCDIR) $(PASSIVEFTP) $(PROFTPD_URL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

proftpd_extract: $(STATEDIR)/proftpd.extract

$(STATEDIR)/proftpd.extract: $(STATEDIR)/proftpd.get
	@echo
	@echo ----------------------- 
	@echo target: proftpd.extract
	@echo -----------------------
	@echo
	$(PROFTPD_EXTRACT) $(PROFTPD_SOURCE) | $(TAR) -C $(BUILDDIR) -xf -
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

proftpd_prepare: $(STATEDIR)/proftpd.prepare

PROFTPD_AUTOCONF = --prefix=/
PROFTPD_ENVIRONMENT =

ifdef PTXCONF_PROFTPD_PAM
PROFTPD_AUTOCONF += --enable-pam
else
PROFTPD_AUTOCONF += --disable-pam
endif
ifdef PTXCONF_PROFTPD_SENDFILE
PROFTPD_AUTOCONF += --enable-sendfile
else
PROFTPD_AUTOCONF += --disable-sendfile
endif
ifdef PTXCONF_PROFTPD_SHADOW
PROFTPD_AUTOCONF += --enable-shadow
else
PROFTPD_AUTOCONF += --disable-shadow
endif
ifdef PTXCONF_PROFTPD_AUTOSHADOW
PROFTPD_AUTOCONF += --enable-autoshadow
else
PROFTPD_AUTOCONF += --disable-autoshadow
endif

$(STATEDIR)/proftpd.prepare: $(STATEDIR)/proftpd.extract
	@echo
	@echo ----------------------- 
	@echo target: proftpd.prepare
	@echo -----------------------
	@echo
	cd $(PROFTPD_DIR) && 						\
	$(PROFTPD_ENVIRONMENT) ./configure $(PROFTPD_AUTOCONF) 
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

proftpd_compile: $(STATEDIR)/proftpd.compile

$(STATEDIR)/proftpd.compile: $(STATEDIR)/proftpd.prepare 
	@echo
	@echo ----------------------- 
	@echo target: proftpd.compile
	@echo -----------------------
	@echo
	make -C $(PROFTPD_DIR) $(MAKEPARMS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

proftpd_install: $(STATEDIR)/proftpd.install

$(STATEDIR)/proftpd.install: $(STATEDIR)/proftpd.compile
	@echo
	@echo ----------------------- 
	@echo target: proftpd.install
	@echo -----------------------
	@echo
	# don't make install - would install files on development host...
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

proftpd_targetinstall: $(STATEDIR)/proftpd.targetinstall

$(STATEDIR)/proftpd.targetinstall: $(STATEDIR)/proftpd.install
	@echo
	@echo ----------------------- 
	@echo target: proftpd.targetinstall
	@echo -----------------------
	@echo
	install $(PROFTPD_DIR)/proftpd $(ROOTDIR)/sbin/proftpd
	$(CROSSSTRIP) -S $(ROOTDIR)/sbin/proftpd
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

proftpd_clean: 
	rm -rf $(STATEDIR)/proftpd.* $(PROFTPD_DIR)

# vim: syntax=make
