# -*-makefile-*-
#
# Copyright (C) 2008 by Wolfram Sang
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
HOST_PACKAGES-$(PTXCONF_HOST_CKERMIT) += host-ckermit

#
# Paths and names
#
HOST_CKERMIT_DIR		= $(HOST_BUILDDIR)/$(CKERMIT)
HOST_CKERMIT_STRIP_LEVEL	:= 0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_CKERMIT_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

HOST_CKERMIT_MAKEVARS := \
	xermit \
	KTARGET=linuxa  \
	prefix= \
	CFLAGS='$(HOST_CPPFLAGS) $(HOST_CFLAGS) -O2 -g -DLINUX -DFNFLOAT -DCK_POSIX_SIG -DCK_NEWTERM -DTCPSOCKET -DLINUXFSSTND -DNOCOTFMC -DPOSIX -DUSE_STRERROR -DCK_NCURSES -DHAVE_PTMX' \
	LNKFLAGS='$(HOST_LDFLAGS)' \
	LIBS='-lncurses -lutil -lresolv -lcrypt -lm'

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-ckermit.install:
	@$(call targetinfo)
	@$(call install, HOST_CKERMIT)
	@ln -sf kermit $(HOST_CKERMIT_PKGDIR)/bin/ckermit
	@install -m755  $(HOST_CKERMIT_DIR)/wart $(HOST_CKERMIT_PKGDIR)/bin/
	@$(call touch)

# vim: syntax=make
