# $Id: proftpd.make,v 1.3 2003/06/26 15:05:58 bsp Exp $
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
PROFTPD_VERSION 	= 1.2.8
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
	@$(call targetinfo, proftpd.get)
	wget -P $(SRCDIR) $(PASSIVEFTP) $(PROFTPD_URL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

proftpd_extract: $(STATEDIR)/proftpd.extract

$(STATEDIR)/proftpd.extract: $(STATEDIR)/proftpd.get
	@$(call targetinfo, proftpd.extract)
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
	@$(call targetinfo, proftpd.prepare)
	cd $(PROFTPD_DIR) && 						\
	$(PROFTPD_ENVIRONMENT) ./configure $(PROFTPD_AUTOCONF) 
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

proftpd_compile: $(STATEDIR)/proftpd.compile

$(STATEDIR)/proftpd.compile: $(STATEDIR)/proftpd.prepare 
	@$(call targetinfo, proftpd.compile)
	make -C $(PROFTPD_DIR) $(MAKEPARMS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

proftpd_install: $(STATEDIR)/proftpd.install

$(STATEDIR)/proftpd.install: $(STATEDIR)/proftpd.compile
	@$(call targetinfo, proftpd.install)
	# don't make install - would install files on development host...
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

proftpd_targetinstall: $(STATEDIR)/proftpd.targetinstall

$(STATEDIR)/proftpd.targetinstall: $(STATEDIR)/proftpd.install
	@$(call targetinfo, proftpd.targetinstall)
	install $(PROFTPD_DIR)/proftpd $(ROOTDIR)/sbin/proftpd
	$(CROSSSTRIP) -S $(ROOTDIR)/sbin/proftpd
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

proftpd_clean: 
	rm -rf $(STATEDIR)/proftpd.* $(PROFTPD_DIR)

# vim: syntax=make
