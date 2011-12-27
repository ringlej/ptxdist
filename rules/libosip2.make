# -*-makefile-*-
#
# Copyright (C) 2011 by Juergen Beisert <jbe@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBOSIP2) += libosip2

#
# Paths and names
#
LIBOSIP2_VERSION	:= 3.6.0
LIBOSIP2_MD5		:= 92fd1c1698235a798497887db159c9b3
LIBOSIP2		:= libosip2-$(LIBOSIP2_VERSION)
LIBOSIP2_SUFFIX		:= tar.gz
LIBOSIP2_URL		:= http://ftp.gnu.org/gnu/osip/$(LIBOSIP2).$(LIBOSIP2_SUFFIX)
LIBOSIP2_SOURCE		:= $(SRCDIR)/$(LIBOSIP2).$(LIBOSIP2_SUFFIX)
LIBOSIP2_DIR		:= $(BUILDDIR)/$(LIBOSIP2)
LIBOSIP2_LICENSE	:= LGPL

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBOSIP2_CONF_TOOL	:= autoconf
LIBOSIP2_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-shared \
	--disable-static \
	--$(call ptx/endis, PTXCONF_LIBOSIP2_DEBUG)-debug \
	--$(call ptx/endis, PTXCONF_LIBOSIP2_TRACE)-trace \
	--disable-mpatrol \
	--disable-gprof \
	--enable-mt \
	--enable-pthread \
	--enable-semaphore \
	--disable-sysv \
	--disable-gperf \
	--disable-hashtable \
	--disable-test

# '--enable-minisize' clobbers the library in many strange ways.
# At the end the libeXosip2, depending on the libosip2, cannot be used anymore,
# but also libeXosip2 with '--enable-minisize' breaks the libeXosip2 itself
# So, no way to use this switch in libosip2 and libeXosip2. What a mess.
LIBOSIP2_CONF_OPT += --disable-minisize

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libosip2.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libosip2)
	@$(call install_fixup, libosip2,PRIORITY,optional)
	@$(call install_fixup, libosip2,SECTION,base)
	@$(call install_fixup, libosip2,AUTHOR,"Juergen Beisert <jbe@pengutronix.de>")
	@$(call install_fixup, libosip2,DESCRIPTION,"oSIP feature")

	@$(call install_lib, libosip2, 0, 0, 0644, libosip2)
	@$(call install_lib, libosip2, 0, 0, 0644, libosipparser2)

	@$(call install_finish, libosip2)

	@$(call touch)

# vim: syntax=make
