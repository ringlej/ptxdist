# -*-makefile-*-
#
# Copyright (C) 2005 by Gilad Ben-Yossef
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
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
NETKIT_FTP_VERSION	:= 0.17
NETKIT_FTP_MD5		:= 94441610c9b86ef45c4c6ec609444060
NETKIT_FTP		:= netkit-ftp-$(NETKIT_FTP_VERSION)
NETKIT_FTP_SUFFIX	:= tar.gz
NETKIT_FTP_URL		:= \
	ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/$(NETKIT_FTP).$(NETKIT_FTP_SUFFIX) \
	http://www.ibiblio.org/pub/Linux/system/network/netkit/$(NETKIT_FTP).$(NETKIT_FTP_SUFFIX)
NETKIT_FTP_SOURCE	:= $(SRCDIR)/$(NETKIT_FTP).$(NETKIT_FTP_SUFFIX)
NETKIT_FTP_DIR		:= $(BUILDDIR)/$(NETKIT_FTP)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(NETKIT_FTP_SOURCE):
	@$(call targetinfo)
	@$(call get, NETKIT_FTP)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

NETKIT_FTP_PATH	:= PATH=$(CROSS_PATH)

#
# autoconf
#
NETKIT_FTP_AUTOCONF := $(CROSS_AUTOCONF_ROOT)

$(STATEDIR)/netkit-ftp.prepare:
	@$(call targetinfo)
	echo "BINDIR=/bin"			>  $(NETKIT_FTP_DIR)/MCONFIG
	echo "MANDIR=/man"			>> $(NETKIT_FTP_DIR)/MCONFIG
	echo "BINMODE=755"			>> $(NETKIT_FTP_DIR)/MCONFIG
	echo "MANMODE=644"			>> $(NETKIT_FTP_DIR)/MCONFIG
	echo "PREFIX=/"				>> $(NETKIT_FTP_DIR)/MCONFIG
	echo "EXECPREFIX=/"			>> $(NETKIT_FTP_DIR)/MCONFIG
	echo "INSTALLROOT=$(NETKIT_FTP_PKGDIR)"	>> $(NETKIT_FTP_DIR)/MCONFIG
	echo $(CROSS_ENV)			>> $(NETKIT_FTP_DIR)/MCONFIG
	echo "LIBTERMCAP=-lncurses"		>> $(NETKIT_FTP_DIR)/MCONFIG
	echo "USE_GLIBC=1"			>> $(NETKIT_FTP_DIR)/MCONFIG
	echo "USE_READLINE=0"			>> $(NETKIT_FTP_DIR)/MCONFIG
	@$(call touch)

NETKIT_FTP_MAKE_ENV	:= $(CROSS_ENV)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/netkit-ftp.targetinstall:
	@$(call targetinfo)

	@$(call install_init, netkit-ftp)
	@$(call install_fixup, netkit-ftp,PRIORITY,optional)
	@$(call install_fixup, netkit-ftp,SECTION,base)
	@$(call install_fixup, netkit-ftp,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, netkit-ftp,DESCRIPTION,missing)

	@$(call install_copy, netkit-ftp, 0, 0, 0755, -, /bin/ftp)

	@$(call install_finish, netkit-ftp)

	@$(call touch)

# vim: syntax=make
