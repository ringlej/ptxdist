# -*-makefile-*-
# $Id: template-make 9053 2008-11-03 10:58:48Z wsa $
#
# Copyright (C) 2005 by Oscar Peredo
# Copyright (C) 2008 by Marc Kleine-Budde <mkl@pengutronix.de>
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
CKERMIT_VERSION	:= 211
CKERMIT		:= cku$(CKERMIT_VERSION)
CKERMIT_SUFFIX	:= tar.gz
CKERMIT_URL	:= http://www.columbia.edu/kermit/ftp/archives/$(CKERMIT).$(CKERMIT_SUFFIX)
CKERMIT_SOURCE	:= $(SRCDIR)/$(CKERMIT).$(CKERMIT_SUFFIX)
CKERMIT_DIR	:= $(BUILDDIR)/$(CKERMIT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(CKERMIT_SOURCE):
	@$(call targetinfo)
	@$(call get, CKERMIT)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/ckermit.extract:
	@$(call targetinfo)
	@$(call clean, $(CKERMIT_DIR))
	mkdir -p $(CKERMIT_DIR)
	@$(call extract, CKERMIT, $(CKERMIT_DIR))
	@$(call patchin, CKERMIT)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

CKERMIT_PATH	:= PATH=$(CROSS_PATH)
CKERMIT_ENV 	:= $(CROSS_ENV)

$(STATEDIR)/ckermit.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

CKERMIT_MAKEVARS := \
	xermit \
	KTARGET=linuxa  \
	prefix=/usr \
	CC=$(CROSS_CC) \
	CC2=$(CROSS_CC) \
	HOST_CC=$(HOSTCC) \
	CFLAGS='$(CROSS_CPPFLAGS) $(CROSS_CFLAGS) -O2 -g -DLINUX -DFNFLOAT -DCK_POSIX_SIG -DCK_NEWTERM -DTCPSOCKET -DLINUXFSSTND -DNOCOTFMC -DPOSIX -DUSE_STRERROR -DCK_NCURSES -DHAVE_PTMX' \
	LNKFLAGS='$(CROSS_LDFLAGS)' \
	LIBS='-lncurses -lm -lcrypt -lresolv'

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ckermit.targetinstall:
	@$(call targetinfo)

	@$(call install_init, ckermit)
	@$(call install_fixup, ckermit,PACKAGE,ckermit)
	@$(call install_fixup, ckermit,PRIORITY,optional)
	@$(call install_fixup, ckermit,VERSION,$(CKERMIT_VERSION))
	@$(call install_fixup, ckermit,SECTION,base)
	@$(call install_fixup, ckermit,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, ckermit,DEPENDS,)
	@$(call install_fixup, ckermit,DESCRIPTION,missing)

	@$(call install_copy, ckermit, 0, 0, 0755, \
		$(CKERMIT_PKGDIR)/usr/bin/kermit, /usr/bin/ckermit)

	@$(call install_finish, ckermit)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ckermit_clean:
	rm -rf $(STATEDIR)/ckermit.*
	rm -rf $(PKGDIR)/ckermit_*
	rm -rf $(CKERMIT_DIR)

# vim: syntax=make
