# -*-makefile-*-
#
# Copyright (C) 2009 by Bjoern Buerger <b.buerger@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_TOTD) += totd

#
# Paths and names
#
TOTD_VERSION	:= 1.5
TOTD_MD5	:= b7da63fc1ea1b2e2ce959732826bc146
TOTD		:= totd-$(TOTD_VERSION)
TOTD_SUFFIX	:= tar.gz
TOTD_URL	:= http://www.dillema.net/software/totd/$(TOTD).$(TOTD_SUFFIX)
TOTD_SOURCE	:= $(SRCDIR)/$(TOTD).$(TOTD_SUFFIX)
TOTD_DIR	:= $(BUILDDIR)/$(TOTD)
PTRTD_LICENSE  	:= multiple AND BSD Style

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
TOTD_MAKE_OPT := CC=$(CROSS_CC)

TOTD_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-malloc-debug \
	--enable-debug-tcp-only


ifdef PTXCONF_TOTD_IPV4
TOTD_AUTOCONF += --enable-ip4
else
TOTD_AUTOCONF += --disable-ip4
endif
ifdef PTXCONF_TOTD_IPV6
TOTD_AUTOCONF += --enable-ip6
else
TOTD_AUTOCONF += --disable-ip6
endif
ifdef PTXCONF_TOTD_STF
TOTD_AUTOCONF += --enable-stf
else
TOTD_AUTOCONF += --disable-stf
endif
ifdef PTXCONF_TOTD_SCOPED_REWRITE
TOTD_AUTOCONF += --enable-scoped-rewrite
else
TOTD_AUTOCONF += --disable-scoped-rewrite
endif
ifdef PTXCONF_TOTD_HTTPD_SERVER
TOTD_AUTOCONF += --enable-http-server
else
TOTD_AUTOCONF += --disable-http-server
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/totd.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  totd)
	@$(call install_fixup, totd,PRIORITY,optional)
	@$(call install_fixup, totd,SECTION,base)
	@$(call install_fixup, totd,AUTHOR,"Bjoern Buerger <b.buerger@pengutronix.de>")
	@$(call install_fixup, totd,DESCRIPTION,missing)

	@$(call install_copy, totd, 0, 0, 0755, -, /usr/sbin/totd)

	@$(call install_finish, totd)

	@$(call touch)

# vim: syntax=make
