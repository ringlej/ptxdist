# -*-makefile-*-
# $Id: template 2606 2005-05-10 21:49:41Z rsc $
#
# Copyright (C) 2005 by Gilad Ben-Yossef
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_NETKIT_FTP) += netkit-ftp

#
# Paths and names
#
NETKIT_FTP_VERSION	= 0.17
NETKIT_FTP		= netkit-ftp-$(NETKIT_FTP_VERSION)
NETKIT_FTP_SUFFIX	= tar.gz
NETKIT_FTP_URL		= ftp://ftp.uk.linux.org/pub/linux/Networking/netkit//$(NETKIT_FTP).$(NETKIT_FTP_SUFFIX)
NETKIT_FTP_SOURCE	= $(SRCDIR)/$(NETKIT_FTP).$(NETKIT_FTP_SUFFIX)
NETKIT_FTP_DIR		= $(BUILDDIR)/$(NETKIT_FTP)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

netkit-ftp_get: $(STATEDIR)/netkit-ftp.get

$(STATEDIR)/netkit-ftp.get: $(netkit-ftp_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(NETKIT_FTP_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, NETKIT_FTP)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

netkit-ftp_extract: $(STATEDIR)/netkit-ftp.extract

$(STATEDIR)/netkit-ftp.extract: $(netkit-ftp_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(NETKIT_FTP_DIR))
	@$(call extract, NETKIT_FTP)
	@$(call patchin, NETKIT_FTP)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

netkit-ftp_prepare: $(STATEDIR)/netkit-ftp.prepare

NETKIT_FTP_PATH	=  PATH=$(CROSS_PATH)
NETKIT_FTP_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
NETKIT_FTP_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/netkit-ftp.prepare: $(netkit-ftp_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(NETKIT_FTP_DIR)/config.cache)
	cd $(NETKIT_FTP_DIR) && \
	echo "BINDIR=/usr/bin" > $(NETKIT_FTP_DIR)/MCONFIG \
	echo "MANDIR=/usr/man" >> $(NETKIT_FTP_DIR)/MCONFIG \
	echo "BINMODE=755" >> $(NETKIT_FTP_DIR)/MCONFIG \
	echo "MANMODE=644" >> $(NETKIT_FTP_DIR)/MCONFIG \
	echo "PREFIX=/usr" >> $(NETKIT_FTP_DIR)/MCONFIG \
	echo "EXECPREFIX=/usr" >> $(NETKIT_FTP_DIR)/MCONFIG \
	echo "INSTALLROOT=" >> $(NETKIT_FTP_DIR)/MCONFIG \
	echo $(CROSS_ENV_CC) >> $(NETKIT_FTP_DIR)/MCONFIG \
	echo "CFLAGS=-O2 -Wall -W -Wpointer-arith -Wbad-function-cast -Wcast-qual -Wstrict-prototypes -Wmissing-prototypes -Wmissing-declarations -Wnested-externs -Winline" >> $(NETKIT_FTP_DIR)/MCONFIG \
	echo "LDFLAGS=" >> $(NETKIT_FTP_DIR)/MCONFIG \
	echo "LIBS=" >> $(NETKIT_FTP_DIR)/MCONFIG \
	echo "LIBTERMCAP=-lncurses" >> $(NETKIT_FTP_DIR)/MCONFIG \
	echo "USE_GLIBC=1" >> $(NETKIT_FTP_DIR)/MCONFIG \
	echo "USE_READLINE=0" >> $(NETKIT_FTP_DIR)/MCONFIG 
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

netkit-ftp_compile: $(STATEDIR)/netkit-ftp.compile

$(STATEDIR)/netkit-ftp.compile: $(netkit-ftp_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(NETKIT_FTP_DIR) && $(NETKIT_FTP_ENV) $(NETKIT_FTP_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

netkit-ftp_install: $(STATEDIR)/netkit-ftp.install

$(STATEDIR)/netkit-ftp.install: $(netkit-ftp_install_deps_default)
	@$(call targetinfo, $@)
	# FIXME
	# @$(call install, NETKIT_FTP)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

netkit-ftp_targetinstall: $(STATEDIR)/netkit-ftp.targetinstall

$(STATEDIR)/netkit-ftp.targetinstall: $(netkit-ftp_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, netkit-ftp)
	@$(call install_fixup, netkit-ftp,PACKAGE,netkit-ftp)
	@$(call install_fixup, netkit-ftp,PRIORITY,optional)
	@$(call install_fixup, netkit-ftp,VERSION,$(NETKIT_FTP_VERSION))
	@$(call install_fixup, netkit-ftp,SECTION,base)
	@$(call install_fixup, netkit-ftp,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, netkit-ftp,DEPENDS,)
	@$(call install_fixup, netkit-ftp,DESCRIPTION,missing)

	@$(call install_copy, netkit-ftp, 0, 0, 0755, $(NETKIT_FTP_DIR)/ftp/ftp, /bin/ftp)

	@$(call install_finish, netkit-ftp)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

netkit-ftp_clean:
	rm -rf $(STATEDIR)/netkit-ftp.*
	rm -rf $(PKGDIR)/netkit-ftp_*
	rm -rf $(NETKIT_FTP_DIR)

# vim: syntax=make
