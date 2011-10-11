# -*-makefile-*-
#
# Copyright (C) 2005 by Oscar Peredo
# Copyright (C) 2008 by Marc Kleine-Budde <mkl@pengutronix.de>
#               2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_CKERMIT) += ckermit

#
# Paths and names
#
CKERMIT_VERSION		:= 302
CKERMIT_MD5		:= eac4dbf18b45775e4cdee5a7c74762b0
CKERMIT			:= cku$(CKERMIT_VERSION)
CKERMIT_SUFFIX		:= tar.gz
CKERMIT_URL		:= ftp://ftp.kermitproject.org/kermit/archives/$(CKERMIT).$(CKERMIT_SUFFIX)
CKERMIT_SOURCE		:= $(SRCDIR)/$(CKERMIT).$(CKERMIT_SUFFIX)
CKERMIT_DIR		:= $(BUILDDIR)/$(CKERMIT)
CKERMIT_STRIP_LEVEL	:= 0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

CKERMIT_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

CKERMIT_MAKEVARS := \
	xermit \
	KTARGET=linuxa  \
	prefix=/usr \
	CC=$(CROSS_CC) \
	CC2=$(CROSS_CC) \
	WART=$(PTXCONF_SYSROOT_HOST)/bin/wart \
	CFLAGS='$(CROSS_CPPFLAGS) $(CROSS_CFLAGS) -O2 -g -DLINUX -DFNFLOAT -DCK_POSIX_SIG -DCK_NEWTERM -DTCPSOCKET -DLINUXFSSTND -DNOCOTFMC -DPOSIX -DUSE_STRERROR -DCK_NCURSES -DHAVE_PTMX' \
	LNKFLAGS='$(CROSS_LDFLAGS)' \
	LIBS='-lncurses -lutil -lresolv -lcrypt -lm'

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ckermit.targetinstall:
	@$(call targetinfo)

	@$(call install_init, ckermit)
	@$(call install_fixup, ckermit,PRIORITY,optional)
	@$(call install_fixup, ckermit,SECTION,base)
	@$(call install_fixup, ckermit,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, ckermit,DESCRIPTION,missing)

	@$(call install_copy, ckermit, 0, 0, 0755, \
		$(CKERMIT_PKGDIR)/usr/bin/kermit, /usr/bin/ckermit)

	@$(call install_finish, ckermit)

	@$(call touch)

# vim: syntax=make
