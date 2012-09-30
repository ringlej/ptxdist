# -*-makefile-*-
#
# Copyright (C) 2012 by Wolfram Sang <w.sang@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DT) += dt

#
# Paths and names
#
DT_VERSION	:= v17.66
DT_MD5		:= bcc2e0e5c26cc066db9c6bffb8906fce
DT		:= dt-source-$(DT_VERSION)
DT_SUFFIX	:= tar.gz
# Tarball copied out of Fedora19 source RPM, since they got the tarball from the author via dropbox
# Official homepage is: http://www.scsifaq.org/RMiller_Tools/dt.html
DT_URL		:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(DT).$(DT_SUFFIX)
DT_SOURCE	:= $(SRCDIR)/$(DT).$(DT_SUFFIX)
DT_DIR		:= $(BUILDDIR)/$(DT)
DT_LICENSE	:= MIT style

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

DT_CONF_TOOL	:= NO
# Standard CFLAGS do not set -DFIFO, -DTAPE and -Wextra, also prefer -O2
DT_MAKE_ENV	:= $(CROSS_ENV)
DT_MAKE_OPT	:= \
	$(CROSS_ENV_PROGS) \
	$(CROSS_ENV_LDFLAGS) \
	CFLAGS="-O2 -DAIO -DFIFO -DMMAP -DTAPE -DTTY -D__linux__ -D_GNU_SOURCE \
		-D_FILE_OFFSET_BITS=64 -DTHREADS -Wextra $(CROSS_CFLAGS)" \
	-f Makefile.linux

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/dt.install:
	@$(call targetinfo)
	install -D -m755 $(DT_DIR)/dt $(DT_PKGDIR)/usr/sbin/dt
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/dt.targetinstall:
	@$(call targetinfo)

	@$(call install_init, dt)
	@$(call install_fixup, dt,PRIORITY,optional)
	@$(call install_fixup, dt,SECTION,base)
	@$(call install_fixup, dt,AUTHOR,"Wolfram Sang <w.sang@pengutronix.de>")
	@$(call install_fixup, dt,DESCRIPTION,missing)

	@$(call install_copy, dt, 0, 0, 0755, -, /usr/sbin/dt)

	@$(call install_finish, dt)

	@$(call touch)

# vim: syntax=make
