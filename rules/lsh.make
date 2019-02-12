# -*-makefile-*-
#
# Copyright (C) 2002-2008 by Pengutronix e.K., Hildesheim, Germany
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LSH) += lsh

#
# Paths and names
#
LSH_VERSION	:= 2.0.4
LSH_MD5		:= 621f4442332bb772b92d397d17ccaf02
LSH		:= lsh-$(LSH_VERSION)
LSH_SUFFIX	:= tar.gz
LSH_URL		:= http://www.lysator.liu.se/~nisse/archive/$(LSH).$(LSH_SUFFIX)
LSH_SOURCE	:= $(SRCDIR)/$(LSH).$(LSH_SUFFIX)
LSH_DIR		:= $(BUILDDIR)/$(LSH)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LSH_CONF_ENV	:= \
	$(CROSS_ENV) \
	ac_cv_header_X11_Xauth_h=no \
	ac_cv_lib_Xau_XauGetAuthByAddr=no

#
# autoconf
#
LSH_CONF_TOOL	:= autoconf
LSH_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_IPV6_OPTION) \
	--sysconfdir=/etc/lsh \
	--includedir=/usr/include/lsh \
	--libdir=/usr/lib/lsh \
	--disable-kerberos \
	--disable-pam \
	--disable-tcp-forward \
	--disable-x11-forward \
	--disable-agent-forward \
	--disable-utmp \
	--without-x \
	--without-system-argp \
	--with-zlib

LSH_CFLAGS := -std=c89

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/lsh.targetinstall:
	@$(call targetinfo)

	@$(call install_init, lsh)
	@$(call install_fixup, lsh,PRIORITY,optional)
	@$(call install_fixup, lsh,SECTION,base)
	@$(call install_fixup, lsh,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, lsh,DESCRIPTION,missing)

ifdef PTXCONF_LSH_EXECUV
	@$(call install_copy, lsh, 0, 0, 0755, -, /usr/sbin/lsh-execuv)
endif

ifdef PTXCONF_LSH_LSHD
	@$(call install_copy, lsh, 0, 0, 0755, -, /usr/sbin/lshd)
endif

ifdef PTXCONF_LSH_SFTPD
	@$(call install_copy, lsh, 0, 0, 0755, -, /usr/sbin/sftp-server)
endif

ifdef PTXCONF_LSH_MAKESEED
	@$(call install_copy, lsh, 0, 0, 0755, -, /usr/bin/lsh-make-seed)
endif

ifdef PTXCONF_LSH_WRITEKEY
	@$(call install_copy, lsh, 0, 0, 0755, -, /usr/bin/lsh-writekey)
endif

ifdef PTXCONF_LSH_KEYGEN
	@$(call install_copy, lsh, 0, 0, 0755, -, /usr/bin/lsh-keygen)
endif
	@$(call install_finish, lsh)
	@$(call touch)

# vim: syntax=make
